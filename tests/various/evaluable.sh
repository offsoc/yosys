#!/usr/bin/env bash

yosys=../../yosys
log="evalcells.log"

bad=

$yosys -QTL $log -qp 'test_cell -list all'
while read line;
do
    if [[ "$line" =~ ^\$.* ]]; then
        if ! $yosys -qqp test_cell\ -n\ 1\ -s\ 1\ "$line"; then
            bad=1
        fi
    fi
done <$log

if [ $bad ]; then
    echo 'One or more evaluable cells failed testing.'
    exit 1
else
    echo 'All evaluable cells match behavior.'
fi
