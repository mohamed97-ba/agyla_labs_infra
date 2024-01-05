import boto3
import json
import os
import decimal

SM_ARN = os.environ["SFN_ARN"]

sm = boto3.client("stepfunctions")

def validate_input(data):
    """
    Validate input data received from API Gateway.
    """
    checks = [
        "waitSeconds" in data,
        isinstance(data.get("waitSeconds"), int),
        "message" in data,
    ]
    return all(checks)

def build_response(status_code, reason=None):
    """
    Build a standardized response.
    """
    return {
        "statusCode": status_code,
        "headers": {
            "Access-Control-Allow-Origin": "*",
            "Content-Type": "application/json",
        },
        "body": json.dumps({"Status": "Success", "Reason": reason}, cls=DecimalEncoder)
        if reason
        else json.dumps({"Status": "Success"}, cls=DecimalEncoder),
    }

def start_state_machine_execution(data):
    """
    Start the state machine execution.
    """
    sm.start_execution(stateMachineArn=SM_ARN, input=json.dumps(data, cls=DecimalEncoder))

def lambda_handler(event, context):
    try:
        # Print event data to logs
        print("Received event: " + json.dumps(event))

        # Load data coming from API Gateway
        data = json.loads(event["body"])
        data["waitSeconds"] = int(data["waitSeconds"])

        # Validate input
        if not validate_input(data):
            return build_response(400, "Input failed validation")
        print("step before create state machine")
        # Start state machine execution
        start_state_machine_execution(data)

        # Return success response
        return build_response(200)

    except Exception as e:
        # Handle any exceptions and return an error response
        error_message = f"Error: {str(e)}"
        return build_response(500, error_message)

class DecimalEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, decimal.Decimal):
            return int(obj)
        return super(DecimalEncoder, self).default(obj)




