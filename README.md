# Gravitee-Gateway Dockerfile for Deis / Hephy

This project aims to create the gravitee gateway wrapper to run on DEIS / HEPHY

# Setup
If you dont have the gateway app already running, you must create it

```bash
deis create gateway
```

If you already have it:

```bash
deis remote --app=gateway
```

## Setup environment variables
Change de values in order to match your environment

```bash
deis config:set \
gravitee_management_mongodb_uri="mongodb://MONGODB_IP:27017/gravitee?serverSelectionTimeoutMS=5000&connectTimeoutMS=5000&socketTimeoutMS=5000" \ 
gravitee_ratelimit_mongodb_uri="mongodb://MONGODB_IP:27017/gravitee?serverSelectionTimeoutMS=5000&connectTimeoutMS=5000&socketTimeoutMS=5000" \
gravitee_reporters_elasticsearch_enabled=true \
gravitee_reporters_elasticsearch_endpoints_0="http://ELASTICSEARCH_IP:9200" \
gravitee_management_type=mongodb \
gravitee_management_mongodb_dbname=myDatabase \
gravitee_management_mongodb_host=IP_ADDRESS \
gravitee_management_mongodb_port=MONGODBPORT \
gravitee_policy_apikey_header="X-Api-Key" \
gravitee_policy_apikey_param="api-key" \
gravitee_handlers_request_transaction_header="X-Transaction-Id" \
PORT=8082
```

## Deploy
Via git
```bash
git push deis
```
