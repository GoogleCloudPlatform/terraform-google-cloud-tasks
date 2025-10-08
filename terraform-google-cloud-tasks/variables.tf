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

#Required variable
variable "queue_iam_choice" {
  description = "Opt 1. iam_binding, 2. iam_member, 3. iam_policy, 4. iam_member_binding (for both iam_member and iam_binding)"
  type        = string
  validation {
    condition = contains(["iam_binding", "iam_member", "iam_policy", "iam_member_binding"], var.queue_iam_choice)
    error_message = "Valid values for 'queue_iam_choice' are: 'iam_binding', 'iam_member', 'iam_policy', or 'iam_member_binding'."
  }
}

#Required variable
variable "iam_name" {
  description = "Used to find the parent resource to bind the IAM policy to"
  type        = string
}

#Required variable
variable "role" {
  description = "The role that should be applied"
  type = string
}

#Required variable
variable "member" {
  description = "Identities that will be granted the privilege in role"
  type = string
}

#Optional variable
variable "app_engine_routing_override" {
  description = "Overrides for task-level appEngineRouting and these settings apply only to App Engine tasks in the queue structure"
  type        = object({
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
  type        = object({
    max_dispatches_per_second = optional(number)
    max_concurrent_dispatches = optional(number)
    max_burst_size            = optional(number)
  })
  default = null
}

#Optional variable
variable "retry_config" {
  description = "Settings that determine the retry behavior"
  type        =  object({
    max_attempts         = optional(number)
    max_retry_duration   = optional(string)
    min_backoff          = optional(string)
    max_backoff          = optional(string)
    max_doublings        = optional(number)
  })
  default = null
}

#Optional variable
variable "stackdriver_logging_config" {
  description = "Configuration options for writing logs to Stackdriver Logging"
  type        = object({
    sampling_ratio = optional(number)
  })
  default = null
}

#Optional variable
variable "http_target" {
  description = "Modifies HTTP target for HTTP tasks"
  type        = object({
    uri_override = object({
      scheme                    = optional(string)
      host                      = optional(string)
      port                      = optional(string)
      path_override             = object ({
        path                    = optional(string)
  })
      query_override            = object({
        query_params            = optional(string)
      })
      uri_override_enforce_mode = optional(string)
    })
    http_method  = optional(string)
    oath_token   = optional(object({
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
variable "desired_state" {
  description = "The desired state of the queue is used to pause and resume the queue"
  type        = string
  default     = "PAUSED"
}

#Optional variable
variable "members" {
  description = "Identities that will be granted the privilege in role"
  type = list(string)
  default = []
}

