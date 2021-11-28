import os
import boto3
import uuid
import random
import time
from datetime import date
from decimal import Decimal
from aws_lambda_powertools import Logger

logger = Logger()

# aws clients
dynamodb = boto3.resource("dynamodb")
# dynamo db cache table
table = dynamodb.Table(os.environ["ORDERS_TABLE"])
ORDERS_QTDE = 10

def lambda_handler(event, context):
    try:
        logger.info("Creating some orders for tests!")
        fill_table(table)
    except Exception as e:
        logger.error("Error: {}".format(e))

def fill_table(table):
    try:
        today = date.today()
        today_str = today.strftime("%d/%m/%Y")
        now = time.time()
        with table.batch_writer() as writer:
            for order in range(ORDERS_QTDE):
                item = {
                    "InvestorId": str(uuid.uuid4()),
                    "InvestorName": "Joe Doe "+str(order),
                    "OrderId": str(uuid.uuid4()),
                    "OrderCreatedAt": Decimal(now),
                    "OrderCreatedAtStr": today_str,
                    "OrderNegotiationPrice": random.randint(0,500),
                    "OrderQuantity": random.randint(0,50)
                }
                writer.put_item(Item=item)
        logger.info("Loaded data into table %s.", table.name)
    except Exception as e:
        logger.exception("Couldn't load data into table %s.", table.name)
        raise
