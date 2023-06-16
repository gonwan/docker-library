# Introduction

Copied and modified from [bitnami](https://github.com/bitnami/containers/tree/main/bitnami/elasticsearch) repository.

The cluster runs under uid 1001. Run `chown -R 1001:1001 elasticsearch_node*_data kibana_data` for volume write permissions, if docker-compose fails.

Go to `Management` --> `Stack Monitoring` --> `Set up with self monitoring` --> `Turn on monitoring`.
