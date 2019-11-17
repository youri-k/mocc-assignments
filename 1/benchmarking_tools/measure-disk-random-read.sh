#!/bin/bash
result=$(fio --rw=randread --name=rand_read_test --size=20M --direct=1 --bs=1024k --runtime=10 --time_based | head -16 | tail -1 | cut -d "," -f 3 | cut -d "=" -f 2)
echo $result