# Introduction
One-command docker compose configuration to set up a MySQL master-slave replication with HA/Failover support.
It's a simplified version inspired by Github: [https://github.blog/2018-06-20-mysql-high-availability-at-github/](https://github.blog/2018-06-20-mysql-high-availability-at-github/).

    Putting the flow together:
    - The orchestrator nodes detect failures.
    - The orchestrator/raft leader kicks off a recovery. A new primary gets promoted.
    - orchestrator/raft advertises the primary change to all raft cluster nodes.
    - Each orchestrator/raft member receives a leader change notification. They each update the local Consul’s KV store with the identity of the new primary.
    - Each GLB/HAProxy has consul-template running, which observes the change in Consul’s KV store, and reconfigures and reloads HAProxy.
    - Client traffic gets redirected to the new primary.

More info: [https://www.percona.com/live/18/sessions/orchestrator-high-availability-tutorial](https://www.percona.com/live/18/sessions/orchestrator-high-availability-tutorial)

# Components
- MySQL 8.0
- Orchestrator 3.1.4
- Consul 1.8
- Consul Template 0.25.1
- HAProxy 2.0

# Run
```
# docker-compose up -d
```
| Component        | Address              | External Address |
| ---------------- | -------------------- |------------------|
| MySQL            | 172.16.111.10:3306   | localhost:13306  |
|                  | 172.16.111.11:3306   | localhost:13307  |
|                  | 172.16.111.12:3306   | localhost:13308  |
| Orchestrator     | 172.16.111.100:3000  | localhost:14000  |
| Consul           | 172.16.111.110:8500  | localhost:14001  |
| Consul Template  | N/A                  | N/A              |
| HAProxy          | 172.16.111.120:3306  | localhost:3306   |
|                  | 172.16.111.120:8000  | localhost:8000   |

Open [http://localhost:14000](http://localhost:14000) to visit Orchestrator.

Connect to MySQL via HAProxy:
```
# mysql -hlocalhost -uroot -psecret_valley
```

Verify cluster failover with:
```
mysql> select @@hostname;
```
