#!/usr/bin/env bash

clear_ftrace_configurations() {
    echo 0 >/sys/kernel/debug/tracing/tracing_on
    echo nop >/sys/kernel/debug/tracing/current_tracer
    echo 0 >/sys/kernel/debug/tracing/events/enable
    echo secondary_start_kernel >/sys/kernel/debug/tracing/set_ftrace_filter
    sleep 1
}

clear_ftrace_configurations

### fill configuration code here ###

clear_ftrace_configurations
