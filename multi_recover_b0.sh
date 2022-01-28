#!/bin/bash
# ulimit -n 8000
#sudo pkill -f dbtest
mkdir -p xxxx_recover
trd=$1
let yyml=trd+1
./out-perf.masstree/benchmarks/dbtest --verbose --bench tpcc --db-type mbta \
                                      --scale-factor $trd --num-threads $trd --numa-memory 1G \
                                      --parallel-loading --runtime 30 \
                                      --bench-opts="--cpu-gap 1 --num-cpus 32" \
                                      -F third-party/paxos/config/local/2follower_$yyml.yml \
                                      -F third-party/paxos/config/occ_paxos.yml \
                                      --paxos-leader-config --multi-process -P localhost -S 1000 -z 0 > ./xxxx_recover/leader-$trd.log 2>&1 &

#tail -f ./xxxx_recover/leader-$trd.log
