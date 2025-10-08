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

output "id" {
  description = "An identifier for the resource with format projects/{{project}}/locations/{{location}}/queues/{{name}}"
  value       = google_cloud_tasks_queue.queue.id
}

# Only when iam_policy resource is passed by the user
output "etag" {
  description = "The etag of the IAM policy"
  value       = length(google_cloud_tasks_queue_iam_policy.iam_policy) > 0 ? google_cloud_tasks_queue_iam_policy.iam_policy[*].etag : null
}
