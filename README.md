# Introduction

AWS DynamoDB example just for compares searchs and indexes strategies

# Business Proposition

The stock market receive many orders every second from the investors, the purpose of our application is to store this data in the DynamoDB and provide the access patterns:

1. Query the orders by customer
2. Query orders by day

## Entities

* Investor (identifier, name)
* Order (identifier, date, negotiation price, quantity)

