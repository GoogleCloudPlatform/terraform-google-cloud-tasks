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

module "cloud_tasks" {
  source = "../.."

  project_id = var.project_id
  queue_name = "test-queue-sl1"
  iam_name   = "test-que-iam"

  queue_iam_choice            = "iam_binding"
  stackdriver_logging_config  = { sampling_ratio = 0.9 }
  app_engine_routing_override = { service = "worker", version = "1.0", instance = "test" }
  location                    = "us-central1"
  member                      = "user:jane@example.com"
  rate_limits                 = { max_concurrent_dispatches = 3, max_dispatches_per_second = 2 }
  role                        = "roles/viewer"
}
