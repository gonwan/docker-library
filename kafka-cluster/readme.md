# Introduction

Copied and modified from [bitnami](https://github.com/bitnami/containers/tree/main/bitnami/kafka) repository. Kafka 3.4 runs in Kraft mode.

The cluster runs under uid 1001. Run `chown -R 1001:1001 kafka_*_data` for volume write permissions, if docker-compose fails.
