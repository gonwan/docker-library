-- Wait for master.
SELECT SLEEP(5);
-- Note: master_host is hardcoded here.
CHANGE MASTER TO master_host='172.16.111.10', master_port=3306, master_user='repl', master_password='repl', MASTER_AUTO_POSITION=1;
START SLAVE;
