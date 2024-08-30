import json


def lambda_handler(event, context):
    # Extract the input string from the HTTP request body
    input_string = event.get("body")

    # Process the input string
    response_string = process_input(input_string)

    # Return the response
    return {"statusCode": 200, "body": json.dumps({"response": response_string})}


def process_input(input_string):
    # Your custom logic goes here
    return f"You said: {input_string}"
