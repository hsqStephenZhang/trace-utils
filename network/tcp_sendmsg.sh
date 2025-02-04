#!/usr/bin/env bash

bpftrace -e 'kprobe:tcp_sendmsg / pid == $1/ {
    @[pid, comm] = sum(arg2);
    @count[pid, comm] = count();
}' $(pgrep $1)
