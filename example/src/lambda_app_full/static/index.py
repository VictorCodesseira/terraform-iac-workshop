import os
import json
import boto3
import logging

logging.basicConfig(level=logging.INFO)

is_localstack = os.environ.get('LOCALSTACK_ENV') == 'true'
 
if is_localstack:
    dynamodb = boto3.resource('dynamodb', region_name = 'us-east-1', endpoint_url='http://localstack:4566')
else:
    dynamodb = boto3.resource('dynamodb')

table_name = os.environ['DYNAMODB_TABLE']
table = dynamodb.Table(table_name)

logging.info(f"Table: {table_name}")

def handler(event, context):
    try:
        logging.debug(f"Event: {event}")
        for record in event['Records']:
            body = json.loads(record["body"])
            message = json.loads(body["Message"])

            record = message["Records"][0]

            event_time = record["eventTime"]

            object = record["s3"]["object"]

            response = table.put_item(Item={'file_key': object['key'], 'size': object['size'], 'created_at': event_time})
            logging.debug(f"Response: {response}")
        return {
            'statusCode': 200,
            'body': json.dumps('Messages written to DynamoDB')
        }
    except Exception as e:
        logging.error(f"Error: {str(e)}")
        return {
            'statusCode': 500,
            'body': json.dumps(f'Error: {str(e)}')
        }