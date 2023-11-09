#!/bin/bash

# Set the S3 bucket name
S3_BUCKET_NAME="hakim-tutorial-labs-s3"
LOG_FILE_PREFIX="ls_output"
AWS_LOG_FILE="/tmp/aws_s3_cp_log.txt"

# Run the command with sudo and store the output in a file with current date and time
OUTPUT_FILE="$LOG_FILE_PREFIX-$(date +'%Y%m%d%H%M%S').txt"
sudo sudo lsof -i > $OUTPUT_FILE

# Upload the output file to S3 and log the result
aws s3 cp $OUTPUT_FILE s3://$S3_BUCKET_NAME/ > $AWS_LOG_FILE 2>&1

# Check if aws s3 cp was successful and log the result
if [ $? -eq 0 ]; then
  echo "Copying to S3 successful." >> $AWS_LOG_FILE
else
  echo "Copying to S3 failed." >> $AWS_LOG_FILE
fi

# Clean up: remove the local output file
rm $OUTPUT_FILE
