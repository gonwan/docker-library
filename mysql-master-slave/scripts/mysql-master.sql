-- See: https://hub.docker.com/_/mysql/
CREATE USER 'repl'@'%' IDENTIFIED BY 'repl';
GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%';
-- See: https://github.com/openark/orchestrator/blob/master/docs/install.md
-- topology
CREATE USER 'orc'@'%' IDENTIFIED BY 'orc';
GRANT SUPER, PROCESS, REPLICATION SLAVE, RELOAD ON *.* TO 'orc'@'%';
GRANT SELECT ON mysql.slave_master_info TO 'orc'@'%';
