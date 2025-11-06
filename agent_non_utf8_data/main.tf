terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

# Test 1: Output binary data directly (PNG header)
resource "null_resource" "binary_output_png" {
  provisioner "local-exec" {
    command = "printf '\\x89\\x50\\x4e\\x47\\x0d\\x0a\\x1a\\x0a' && echo 'This is after binary data'"
  }

  triggers = {
    always_run = timestamp()
  }
}

# Test 2: Output random binary data
resource "null_resource" "binary_output_random" {
  provisioner "local-exec" {
    command = "python3 -c 'import sys; sys.stdout.buffer.write(b\"\\x89\\xff\\xfe\\xfd\"); sys.stdout.flush(); print(\"text after binary\")'"
  }

  triggers = {
    always_run = timestamp()
  }

  depends_on = [null_resource.binary_output_png]
}

# Test 3: Cat a binary file (most realistic scenario)
resource "null_resource" "create_binary_file" {
  provisioner "local-exec" {
    command = "printf '\\x89\\x50\\x4e\\x47\\x0d\\x0a\\x1a\\x0a Some text with binary header' > /tmp/test_binary.dat"
  }

  triggers = {
    always_run = timestamp()
  }
}

resource "null_resource" "output_binary_file" {
  provisioner "local-exec" {
    # This outputs 0x89 (PNG header byte) followed by text
    command = "printf '\\x89PNG_HEADER\\x0d\\x0a' && echo 'Normal text after binary'"
  }

  triggers = {
    always_run = timestamp()
  }

  depends_on = [null_resource.create_binary_file]
}

# Test 4: Archive provider that might cause issues
data "archive_file" "test" {
  type        = "zip"
  output_path = "test.zip"

  source {
    content  = "Hello World"
    filename = "test.txt"
  }
}

output "test" {
  value = "café"
}

resource "null_resource" "output_archive" {
  provisioner "local-exec" {
    # This will output binary zip content
    command = "cat ${data.archive_file.test.output_path}"
  }

  triggers = {
    always_run = timestamp()
  }

  depends_on = [
    null_resource.output_binary_file,
    data.archive_file.test
  ]
}