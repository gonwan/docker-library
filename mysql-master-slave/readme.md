# Introduction
One-command docker compose to set up a MySQL master-slave replication with HA support.

# Components
- MySQL 8.0
- Orchestrator 3.1.4

# Run
```
# docker-compose up -d
```
Open [http://localhost:14000](http://localhost:14000), discovery 172.16.111.10:3306 cluster.
