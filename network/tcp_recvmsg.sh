#!/usr/bin/env bash

bpftrace -e '
kretprobe:tcp_recvmsg / pid == $1 / {
    @bytes_received[pid, comm] = sum(retval);
    @recv_count[pid, comm] = count();
    $size = retval;
    if ($size < 0) {
        @errors[pid, comm] = count();
    }
}
' $(pgrep $1)
