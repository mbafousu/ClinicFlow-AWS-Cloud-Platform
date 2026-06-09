import json
import os
import uuid
import boto3

dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table(os.environ["TABLE_NAME"])

def make_response(status_code, body):
    return {
        "statusCode": status_code,
        "headers": {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": "*"
        },
        "body": json.dumps(body)
    }

def lambda_handler(event, context):
    method = event.get("requestContext", {}).get("http", {}).get("method")

    if method == "POST":
        body = json.loads(event.get("body", "{}"))

        appointment = {
            "appointmentId": str(uuid.uuid4()),
            "patientName": body.get("patientName", ""),
            "provider": body.get("provider", ""),
            "appointmentDate": body.get("appointmentDate", ""),
            "appointmentTime": body.get("appointmentTime", ""),
            "reason": body.get("reason", ""),
            "status": body.get("status", "Scheduled")
        }

        table.put_item(Item=appointment)
        return make_response(201, {
            "message": "Appointment created successfully",
            "appointment": appointment
        })

    if method == "GET":
        result = table.scan()
        return make_response(200, result.get("Items", []))

    return make_response(400, {"message": "Unsupported method"})