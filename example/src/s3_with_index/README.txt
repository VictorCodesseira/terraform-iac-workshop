awslocal s3 ls my-new-bucket
awslocal s3 cp ./static/file.txt s3://my-new-bucket 

awslocal logs describe-log-groups
awslocal logs filter-log-events --log-group-name '/aws/lambda/my-new-bucket-index-function' --query 'events[*].message'

awslocal dynamodb scan --table-name my-new-bucket-index-table
