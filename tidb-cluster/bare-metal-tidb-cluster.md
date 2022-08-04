## Environment

#### CentOS 7.x required. Install packages on each target machine

```shell
# yum install ntp sshpass numactl -y
```

#### Add a `tidb` user

```shell
# useradd tidb && passwd tidb
```
Edit `/etc/sudoers` to enable privileges, add lines to the end of the file:
```
tidb ALL=(ALL) NOPASSWD: ALL
```
Also comment out the line if exists:
```
#Defaults    requiretty
```

#### Enable SSH no-password login

Generate SSH key, run on each target machine:
```shell
# ssh-keygen -t rsa
```
Run on the main control machine, add all target machines including itself:
```shell
# ssh-copy-id -i ~/.ssh/id_rsa.pub 172.16.58.248
```

#### Modify `ext4` options on target machines, which install TiKV

Edit `/etc/fstab`, add `nodelalloc` and `noatime` options, reboot required if `/` is affected:
```
UUID=7b56bcb3-a401-446c-8b0f-e233d2ae184c /                       ext4    defaults,nodelalloc,noatime        1 1
```

#### Configure OS parameters

Disable THP (Transparent Huge Pages). Set the I/O Scheduler of the storage media to `noop`. Choose the `performance` mode for the cpufrequ module which controls the CPU frequency. Use `tuned` on each target machine:
```shell
# mkdir /etc/tuned/balanced-tidb-optimal/
# vi /etc/tuned/balanced-tidb-optimal/tuned.conf
```
```
[main]
include=balanced

[cpu]
governor=performance

[vm]
transparent_hugepages=never

[disk]
devices_udev_regex=(ID_SERIAL=36d0946606d79f90025f3e09a0c1fc035)|(ID_SERIAL=36d0946606d79f90025f3e09a0c1f9e81)
elevator=noop
```
Add the new profile:
```shell
# tuned-adm profile balanced-tidb-optimal
```

## Installation

#### Install `tiup`

```shell
# curl --proto '=https' --tlsv1.2 -sSf https://tiup-mirrors.pingcap.com/install.sh | sh
```

#### Install using offline packages

Upload:
```shell
# scp -P 22 tidb-community-server-v5.4.2-linux-amd64.tar.gz tidb@172.16.56.137/home/tidb
```
Extract:
```shell
# tar xzvf tidb-community-server-v5.4.2-linux-amd64.tar.gz && \
sh tidb-community-server-v5.4.2-linux-amd64/local_install.sh && \
source /home/tidb/.bash_profile
```
Check and repair potential risks:
```shell
# tiup cluster check ./complex-mini.yaml --user tidb
# tiup cluster check ./complex-mini.yaml --user tidb --apply
```
Check the status of the cluster:
```shell
# tiup cluster display tidb-cluster-test
```
Start the cluster, record the generated root password:
```shell
# tiup cluster start tidb-cluster-test --init
```
```
Started cluster `tidb-cluster-test` successfully.
The root password of TiDB database has been changed.
The new password is: 'y_+3Hwp=*AWz8971s6'.
Copy and record it to somewhere safe, it is only displayed once, and will not be stored.
The generated password can NOT be got again in future.
```
Check the status of the cluster again:
```shell
# tiup cluster display tidb-cluster-test
```
```
tiup is checking updates for component cluster ...
Starting component `cluster`: /home/tidb/.tiup/components/cluster/v1.10.2/tiup-cluster display tidb-cluster-test
Cluster type:       tidb
Cluster name:       tidb-cluster-test
Cluster version:    v5.4.2
Deploy user:        tidb
SSH type:           builtin
Dashboard URL:      http://172.16.58.251:2379/dashboard
Grafana URL:        http://172.16.56.108:3000
ID                   Role          Host           Ports        OS/Arch       Status  Data Dir                      Deploy Dir
--                   ----          ----           -----        -------       ------  --------                      ----------
172.16.56.108:9093   alertmanager  172.16.56.108  9093/9094    linux/x86_64  Up      /tidb-data/alertmanager-9093  /tidb-deploy/alertmanager-9093
172.16.56.108:3000   grafana       172.16.56.108  3000         linux/x86_64  Up      -                             /tidb-deploy/grafana-3000
172.16.58.248:2379   pd            172.16.58.248  2379/2380    linux/x86_64  Up|L    /tidb-data/pd-2379            /tidb-deploy/pd-2379
172.16.58.251:2379   pd            172.16.58.251  2379/2380    linux/x86_64  Up|UI   /tidb-data/pd-2379            /tidb-deploy/pd-2379
172.16.58.252:2379   pd            172.16.58.252  2379/2380    linux/x86_64  Up      /tidb-data/pd-2379            /tidb-deploy/pd-2379
172.16.56.108:9090   prometheus    172.16.56.108  9090/12020   linux/x86_64  Up      /tidb-data/prometheus-9090    /tidb-deploy/prometheus-9090
172.16.56.107:4000   tidb          172.16.56.107  4000/10080   linux/x86_64  Up      -                             /tidb-deploy/tidb-4000
172.16.56.110:4000   tidb          172.16.56.110  4000/10080   linux/x86_64  Up      -                             /tidb-deploy/tidb-4000
172.16.56.111:4000   tidb          172.16.56.111  4000/10080   linux/x86_64  Up      -                             /tidb-deploy/tidb-4000
172.16.56.137:20160  tikv          172.16.56.137  20160/20180  linux/x86_64  Up      /tidb-data/tikv-20160         /tidb-deploy/tikv-20160
172.16.56.138:20160  tikv          172.16.56.138  20160/20180  linux/x86_64  Up      /tidb-data/tikv-20160         /tidb-deploy/tikv-20160
172.16.56.139:20160  tikv          172.16.56.139  20160/20180  linux/x86_64  Up      /tidb-data/tikv-20160         /tidb-deploy/tikv-20160
```

