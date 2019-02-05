# Gravitee-Gateway-Docker

# Setup
If you doesnt have the gateway app already running, you must create it

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
gravitee.management.type=mongodb \
gravitee.management.mongodb.dbname=myDatabase \
gravitee.management.mongodb.host=IP_ADDRESS \
gravitee.management.mongodb.port=MONGODBPORT \
gravitee.policy.api-key.header=X-Api-Key \
gravitee.policy.api-key.param=api-key \
gravitee.handlers.request.transaction.header=X-Transaction-Id \
PORT=8082
```

## Deploy
Via git
```bash
git push deis
```
