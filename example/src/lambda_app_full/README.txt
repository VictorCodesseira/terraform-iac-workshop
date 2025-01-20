awslocal s3 ls my-bucket 
awslocal s3 cp ./static/file.txt s3://my-bucket 

awslocal logs describe-log-groups
awslocal logs filter-log-events --log-group-name '/aws/lambda/my-function' --query 'events[*].message'

awslocal dynamodb scan --table-name my-table
