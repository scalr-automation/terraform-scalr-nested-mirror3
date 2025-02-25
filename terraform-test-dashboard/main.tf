variable "run_id" {
  default = "run_id_13"
}

variable "sleep_time" {
  default = 60
}

resource "random_uuid" "test" {
  count = 2
}

resource "random_integer" "timeout" {
  min = 32
  max = 180

  keepers = {
    run_id = var.run_id
  }
}

resource "random_uuid" "test2" {
  count = 5
}

output "uuid_out" {
  value     = random_uuid.test2[*].result
  sensitive = false
}


resource "null_resource" "env_vars" {
  triggers = {
    run_id = var.run_id
  }
  provisioner "local-exec" {
    command = "env"
  }
}

output "very_long" {
  value       = "Lorem dfipsusdm dolor sit ameывt, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\nUt enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.\nExcepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"
  description = "Lorem dfipsusdm dolor sit ameывt, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\nUt enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.\nExcepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"
}

output "senc_out" {
  value       = "secret data"
  description = "my sensitive output"
  sensitive   = true
}

output "output_run_id" {
  value = var.run_id
}

output "note" {
  value = <<-EOT
        Web:
          URL                   : https://example.testenv.scalr.dev
          Username              : admin
          Password              : **************
        Shell:
          kubectl -n example exec -it scalr-server-0 -c scalr -- bash
        Port-forwarding:
          kubectl -n example port-forward scalr-server-0 8022:22
        UI Watcher:
          ssh -v testenv -N -R 0.0.0.0:3000:127.0.0.1:3000
          npx next ui/next
        Documentation:
          https://example.com/#user-guide
    EOT

  sensitive = false
}

output "uuid_obj1" {
  value = { key0 : random_uuid.test[0].result, key1 : random_uuid.test[1].result, key2 : "lorem" }
}

output "uuid_obj2" {
  value = {
    key0 : random_uuid.test[0].result, key1 : random_uuid.test[1].result, key2 : "lorem",
    key3 : { key0 : random_uuid.test[0].result, key1 : random_uuid.test[1].result, key2 : "lorem" }
  }
}