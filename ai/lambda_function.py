import json
from main import *


def lambda_handler(event, context):
    # Extract the input string from the HTTP request body
    prompt = event.get("prompt")

    # Process the input string
    result = main(prompt)

    # Return the response
    return {"statusCode": 200, "body": {"flow": result}}
