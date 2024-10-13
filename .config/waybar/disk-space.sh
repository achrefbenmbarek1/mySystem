#!/bin/bash
df -h / | awk 'NR==2 {print $4 " free"}'
