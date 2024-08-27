import json
import boto3
import os
from decimal import Decimal

dynamodb = boto3.resource('dynamodb')
tableName = os.environ['TABLE_NAME']
table = dynamodb.Table(tableName)

def lambda_handler(event, context):
    visit_count: int = 0
    
    # Get count from table
    response = table.get_item(Key={'id': Decimal(0)})
    if 'Item' in response:
        visit_count = int(response['Item']['count'])
        
    # Increment current count
    visit_count += 1
    
    table.put_item(Item={'id': 0, 'count': visit_count})
    print(visit_count)
    return {
        'statusCode': 200,
        'body': json.dumps({'count': visit_count})
    }
