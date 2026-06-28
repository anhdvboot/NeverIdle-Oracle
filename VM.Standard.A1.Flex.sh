#!/bin/bash
bash <(curl -s -L https://raw.githubusercontent.com/anhdvboot/NeverIdle-Oracle/refs/heads/main/onekey-NeverIdle.sh)
pkill NeverIdle
/tmp/NeverIdle -c 12h -cp 0.2 -m 5 -n 12h

# Nếu VPS chưa chạy gì thì nên để là -cp và giảm số lần speed test xuống
# /tmp/NeverIdle -cp 0.3 -m 5 -n 2h
