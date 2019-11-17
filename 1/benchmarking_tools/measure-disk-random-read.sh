#!/bin/bash
result=$(fio --rw=randread --name=rand_read_test --size=20M --direct=1 --bs=1024k --numjobs=4 --group_reporting --runtime=2 --time_based | head -7 | tail -1 | cut -d "," -f 3 | cut -c 7-)
echo $result