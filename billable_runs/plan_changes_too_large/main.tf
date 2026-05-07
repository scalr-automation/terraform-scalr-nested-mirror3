terraform {
  required_providers {
    external = {
      source  = "hashicorp/external"
      version = "~> 2.0"
    }
  }
}

resource "terraform_data" "name" {
  
}

# Data source that creates multiple files and folders (~1GB total - 10x original)
data "external" "create_large_files" {
  program = ["bash", "-c", <<-EOF
# Create directory structure
mkdir -p ./data/logs ./data/config ./data/backups ./data/temp

# Create 100MB file (logs)
dd if=/dev/zero of=./data/logs/app.log bs=1M count=100 2>/dev/null

# Create 150MB file (more logs)
dd if=/dev/zero of=./data/logs/system.log bs=1M count=150 2>/dev/null

# Create 200MB file (backup)
dd if=/dev/zero of=./data/backups/backup_01.tar bs=1M count=200 2>/dev/null

# Create 250MB file (another backup)
dd if=/dev/zero of=./data/backups/backup_02.tar bs=1M count=250 2>/dev/null

# Create 100 config files (100 files x 1MB = 100MB)
for i in {1..100}; do
  dd if=/dev/zero of=./data/config/config_$i.json bs=1M count=1 2>/dev/null
done

# Create 100 temp files (100 files x 1MB = 100MB)
for i in {1..100}; do
  dd if=/dev/zero of=./data/temp/temp_$i.bin bs=1M count=1 2>/dev/null
done

# Create 50 debug files with random data (50 files x 2MB = 100MB)
for i in {1..50}; do
  head -c 2M </dev/urandom | base64 > ./data/logs/debug_$i.txt
done

# Calculate total size
total_size=$(du -sb ./data 2>/dev/null | cut -f1)
total_mb=$((total_size / 1024 / 1024))
file_count=$(find ./data -type f | wc -l)

echo "{\"status\":\"created\",\"total_size_mb\":\"$total_mb\",\"file_count\":\"$file_count\",\"base_dir\":\"./data\"}"
EOF
  ]
}


data "external" "create_large_files_low_compression" {
  program = ["bash", "-c", <<-EOF
dd if=/dev/urandom of=./bigfile.bin bs=1M count=150 2>/dev/null
size=$(du -sb ./bigfile.bin | cut -f1)
echo "{\"size\":\"$size\"}"
EOF
  ]
}