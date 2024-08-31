import json


def lambda_handler(event, context):
    # Extract the input string from the HTTP request body
    prompt = event.get("prompt")

    # Process the input string
    flow = process_input(prompt)

    # Return the response
    return {"statusCode": 200, "body": {"flow": flow}}


def process_input(input_string):
    # Your custom logic goes here
    return {"title": "test", "description": "testing", "triggers": [], "actions": []}
