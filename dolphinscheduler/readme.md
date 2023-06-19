# Introduction

Copied and modified from the official [docker-compose](https://github.com/apache/dolphinscheduler/tree/dev/deploy/docker) file.
```shell
# initialize database
$ docker-compose up -d dolphinscheduler-postgresql dolphinscheduler-schema-initializer
# start dolphinscheduler servers
$ docker-compose up -d dolphinscheduler-postgresql dolphinscheduler-zookeeper dolphinscheduler-api dolphinscheduler-alert dolphinscheduler-master dolphinscheduler-worker
```

Now, go to `http://localhost:12345/dolphinscheduler` with `admin/dolphinscheduler123`.

The postgres and zookeeper server come from bitnami, and run under uid [1001](https://github.com/bitnami/containers/tree/main/bitnami/osclass). Run `chown -R 1001:1001 *data*` for volume write permissions, if docker-compose fails.
