import json
import boto3
import os

ecs = boto3.client('ecs')

def lambda_handler(event, context):
    print("Received event: " + json.dumps(event))
    headers = event.get("headers", {})
    print("Headers: ", headers)

    # Read credentials from webhook headers
    scalr_token = headers.get('X-Scalr-Token')
    scalr_url = headers.get('X-Scalr-Url')

    if not scalr_token or not scalr_url:
        error_msg = 'Missing required headers: X-Scalr-Token or X-Scalr-Url'
        print(error_msg)
        return {
            'statusCode': 400,
            'body': json.dumps(error_msg)
        }

    # Get configuration from environment variables
    subnet_ids = os.environ['SUBNET_IDS'].split(',')
    container_name = os.environ.get('CONTAINER_NAME', 'scalr-agent')

    try:
        ecs.run_task(
            cluster=os.environ['CLUSTER'],
            launchType='FARGATE',
            taskDefinition=os.environ['TASK_DEFINITION'],
            networkConfiguration={
                'awsvpcConfiguration': {
                    'subnets': subnet_ids,
                    'securityGroups': [os.environ['SECURITY_GROUP']],
                    'assignPublicIp': 'ENABLED'
                }
            },
            overrides={
                'containerOverrides': [{
                    'name': container_name,
                    'environment': [
                        {'name': 'SCALR_URL', 'value': scalr_url},
                        {'name': 'SCALR_TOKEN', 'value': scalr_token},
                        {'name': 'SCALR_SINGLE', 'value': 'true'},
                        {'name': 'SCALR_DRIVER', 'value': 'local'}
                    ]
                }]
            }
        )
        print(f"Successfully triggered ECS task for Scalr URL: {scalr_url}")
    except Exception as e:
        error_msg = f"Failed to trigger ECS task: {str(e)}"
        print(error_msg)
        return {
            'statusCode': 500,
            'body': json.dumps(error_msg)
        }

    return {
        'statusCode': 200,
        'body': json.dumps('Fargate task triggered!')
    }