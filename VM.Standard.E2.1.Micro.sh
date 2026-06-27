#!/bin/bash
bash <(curl -s -L https://raw.githubusercontent.com/anhdvboot/NeverIdle-Oracle/refs/heads/main/onekey-NeverIdle.sh)
pkill NeverIdle
/tmp/NeverIdle -c 12h -cp 0.2 -n 12h
