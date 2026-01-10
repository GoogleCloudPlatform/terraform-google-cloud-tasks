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

#Required variable
variable "queue_name" {
  description = "The queue name"
  type        = string
}

#Required variable
variable "location" {
  description = "The location of the queue"
  type        = string
}

#Required variable
variable "project_id" {
  description = "The ID of the project in which the resource belongs"
  type        = string
}

variable "queue_iam_choice" {
  description = "Opt 1. iam_binding, 2. iam_member, 3. iam_policy, 4. iam_member_binding (for both iam_member and iam_binding)"
  type        = string
  default     = null
}

#Required variable
variable "role" {
  description = "The role that should be applied, must be passed when a iam_choice is not null"
  type        = string
  default     = null
}

#Required variable
variable "member" {
  description = "Identities that will be granted the privilege in role, must be passed when iam_choice is iam_member"
  type        = string
  default     = null
}

#Optional variable
variable "app_engine_routing_override" {
  description = "Overrides for task-level appEngineRouting and these settings apply only to App Engine tasks in the queue structure"
  type = object({
    service  = optional(string)
    version  = optional(string)
    instance = optional(string)
    host     = optional(string)
  })
  default = null
}

#Optional variable
variable "rate_limits" {
  description = "Rate limits for task dispatches"
  type = object({
    max_dispatches_per_second = optional(number)
    max_concurrent_dispatches = optional(number)
    max_burst_size            = optional(number)
  })
  default = null
}

#Optional variable
variable "retry_config" {
  description = "Settings that determine the retry behavior"
  type = object({
    max_attempts       = optional(number)
    max_retry_duration = optional(string)
    min_backoff        = optional(string)
    max_backoff        = optional(string)
    max_doublings      = optional(number)
  })
  default = null
}

#Optional variable
variable "stackdriver_logging_config" {
  description = "Configuration options for writing logs to Stackdriver Logging"
  type = object({
    sampling_ratio = optional(number)
  })
  default = null
}

#Optional variable
variable "http_target" {
  description = "Modifies HTTP target for HTTP tasks"
  type = object({
    uri_override = object({
      scheme = optional(string)
      host   = optional(string)
      port   = optional(string)
      path_override = object({
        path = optional(string)
      })
      query_override = object({
        query_params = optional(string)
      })
      uri_override_enforce_mode = optional(string)
    })
    http_method = optional(string)
    oath_token = optional(object({
      service_account_email = string
      scope                 = optional(string)
    }))
    oidc_token = optional(object({
      service_account_email = string
      audience              = optional(string)
    }))
  })
  default = null
}

#Optional variable
variable "members" {
  description = "Identities that will be granted the privilege in role, must be passed when iam_choice is iam_binding or iam_policy"
  type        = list(string)
  default     = []
}
