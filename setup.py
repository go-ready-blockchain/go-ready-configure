import boto3
import json

client = boto3.client('dynamodb')

with open("tables.json","r") as fp:
    data = json.load(fp)


if __name__ == '__main__':
    for i in data:

        print("Creating Table: " +i['TableName'])
        table = client.create_table(
            TableName=i['TableName'],
            KeySchema=[
                {
                    'AttributeName': i['Key'],
                    'KeyType': i['KeyType']  # Partition key
                }
            ],
            AttributeDefinitions=[
                {
                    'AttributeName': i['Key'],
                    'AttributeType': i['AttributeType']
                }

            ],
        ProvisionedThroughput={
            'ReadCapacityUnits': 5,
            'WriteCapacityUnits': 5
        })
        print("Table status:", table)
    
    print("Done..!")
