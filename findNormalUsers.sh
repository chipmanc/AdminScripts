#!/bin/bash
awk -F':' '$3 > 500 {print $1}' /etc/passwd

