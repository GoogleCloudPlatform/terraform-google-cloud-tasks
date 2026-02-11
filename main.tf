/**
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

data "google_iam_policy" "admin" {
  count = var.queue_iam_choice == "iam_policy" && var.role != null && var.members != null ? 1 : 0

  binding {
    role    = var.role
    members = var.members
  }
}

resource "google_cloud_tasks_queue" "queue" {
  name     = var.queue_name
  location = var.location
  project  = var.project_id

  dynamic "app_engine_routing_override" {
    for_each = var.app_engine_routing_override[*]
    content {
      service  = app_engine_routing_override.value["service"]
      version  = app_engine_routing_override.value["version"]
      instance = app_engine_routing_override.value["instance"]
      host     = app_engine_routing_override.value["host"]
    }
  }

  dynamic "rate_limits" {
    for_each = var.rate_limits[*]
    content {
      max_dispatches_per_second = rate_limits.value["max_dispatches_per_second"]
      max_concurrent_dispatches = rate_limits.value["max_concurrent_dispatches"]
      max_burst_size            = rate_limits.value["max_burst_size"]
    }
  }

  dynamic "retry_config" {
    for_each = var.retry_config[*]
    content {
      max_attempts       = retry_config.value["max_attempts"]
      max_retry_duration = retry_config.value["max_retry_duration"]
      min_backoff        = retry_config.value["min_backoff"]
      max_backoff        = retry_config.value["max_backoff"]
      max_doublings      = retry_config.value["max_doublings"]
    }
  }

  dynamic "stackdriver_logging_config" {
    for_each = var.stackdriver_logging_config[*]
    content {
      sampling_ratio = stackdriver_logging_config.value["sampling_ratio"]
    }
  }

  dynamic "http_target" {
    for_each = var.http_target[*]
    content {
      http_method = http_target.value["http_method"]

      dynamic "uri_override" {
        for_each = http_target.value["uri_override"]
        content {
          scheme = uri_override.value["scheme"]
          host   = uri_override.value["host"]
          port   = uri_override.value["port"]
          dynamic "path_override" {
            for_each = uri_override.value["path_override"]
            content {
              path = path_override.value["path"]
            }
          }
          dynamic "query_override" {
            for_each = uri_override.value["query_override"]
            content {
              query_params = query_override.value["query_override"]
            }
          }
          uri_override_enforce_mode = uri_override.value["uri_override_enforce_mode"]
        }
      }

      dynamic "oidc_token" {
        for_each = http_target.value["oidc_token"]
        content {
          service_account_email = oidc_token.value["service_account_email"]
          audience              = oidc_token.value["audience"]
        }
      }
    }
  }
}

resource "google_cloud_tasks_queue_iam_member" "iam_member" {
  count    = var.queue_iam_choice != null && contains(["iam_member", "iam_member_binding"], var.queue_iam_choice) && var.role != null && var.member != null ? 1 : 0
  name     = var.queue_name
  location = var.location
  project  = var.project_id
  member   = var.member
  role     = var.role
  depends_on = [
    google_cloud_tasks_queue.queue
  ]
}

resource "google_cloud_tasks_queue_iam_binding" "iam_binding" {
  count    = var.queue_iam_choice != null && contains(["iam_binding", "iam_member_binding"], var.queue_iam_choice) && var.role != null && var.members != null ? 1 : 0
  name     = var.queue_name
  location = var.location
  project  = var.project_id
  members  = var.members
  role     = var.role
  depends_on = [
    google_cloud_tasks_queue.queue
  ]
}

resource "google_cloud_tasks_queue_iam_policy" "iam_policy" {
  count       = var.queue_iam_choice == "iam_policy" && var.role != null && var.members != null ? 1 : 0
  name        = var.queue_name
  location    = var.location
  project     = var.project_id
  policy_data = data.google_iam_policy.admin[0].policy_data
  depends_on = [
    google_cloud_tasks_queue.queue
  ]
}
