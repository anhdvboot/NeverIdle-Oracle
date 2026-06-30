# Bypass Oracle VM.Standard.E2.1.Micro 

Link gốc: https://gist.githubusercontent.com/Ansen/e45320205faf5786d3282ac880f20bab/raw/onekey-NeverIdle.sh

Speedtest lỗi thì dùng qua cloudflare, không cần cài speedtest -cli

```
cat > /root/speedtest.sh << 'EOF'
#!/bin/bash
SPEED=$(curl -o /dev/null -s -w "%{speed_download}" https://speed.cloudflare.com/__down?bytes=50000000)
echo "$(date '+%Y-%m-%d %H:%M:%S') - Speed: $(echo $SPEED | awk '{printf "%.2f", $1/125000}') Mbit/s" >> /root/speedtest.log
EOF
chmod +x /root/speedtest.sh
```

Nội dung crontab -e

```
SHELL=/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
HOME=/root

@reboot nohup /usr/local/bin/bypass_oracle.sh >> /root/out 2>&1 <&- &
*/2 * * * * /root/speedtest.sh
```

Nên dùng tham cố -cp 0.3 để luôn chạy 30% nếu vps chưa làm gì

Với E21 Micro

```
-cp 0.3 -n 2h
```

Với Flex

```
-cp 0.3 -m 5 -n 2h
```

## Theo dõi VPS

Kiểm tra NeverIdle có chạy không

```
ps aux | grep NeverIdle | grep -v grep
```

Nếu kiểm tra lỗi -n thì nên bỏ speedteset qua cli

```
tail -f ~/out
```

Stop

```
pkill NeverIdle
```

Sửa mã: `-cp 0.3` với E21 Micro và `-cp 0.3 -m 5` với Flex

Cài speedtest cli

```
apt install speedtest-cli -y
```

Gỡ speedtest cli

```
apt remove speedtest-cli -y
```

```
crontab -e
```

Thêm 

```
@reboot nohup /bin/bash /usr/local/bin/bypass_oracle.sh >> /root/out 2>&1 <&- &
0 */2 * * * /usr/bin/speedtest-cli --simple >> /root/speedtest.log 2>&1
```

Test thử

```
speedtest-cli --simple
```

Speedtest lỗi thì dùng qua cloudflare, không cần cài speedtest -cli

```
cat > /root/speedtest.sh << 'EOF'
#!/bin/bash
SPEED=$(curl -o /dev/null -s -w "%{speed_download}" https://speed.cloudflare.com/__down?bytes=50000000)
echo "$(date '+%Y-%m-%d %H:%M:%S') - Speed: $(echo $SPEED | awk '{printf "%.2f", $1/125000}') Mbit/s" >> /root/speedtest.log
EOF
chmod +x /root/speedtest.sh
```

Nội dung crontab -e

```
SHELL=/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
HOME=/root

@reboot nohup /usr/local/bin/bypass_oracle.sh >> /root/out 2>&1 <&- &
*/2 * * * * /root/speedtest.sh
```


Chạy lệnh

```
nohup /bin/bash /usr/local/bin/bypass_oracle.sh >> /root/out 2>&1 <&- &
```

Xem log

```
tail -f ~/speedtest.log
```

```
/usr/local/bin/bypass_oracle.sh
```

### Trên cấu hình Oracle VM.Standard.E2.1.Micro

Sau mỗi 12h sẽ tự sử dụng 20% CPU, tự chạy speedtest 1 lần để sử dụng network

```
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/NeverIdle-Oracle/master/VM.Standard.E2.1.Micro.sh -O /usr/local/bin/bypass_oracle.sh
```
```
chmod +x /usr/local/bin/bypass_oracle.sh
```
```
nohup /bin/bash /usr/local/bin/bypass_oracle.sh >> /root/out 2>&1 <&- &
```

Chạy crontab -e và dán:
```
echo "@reboot nohup /bin/bash /usr/local/bin/bypass_oracle.sh >> /root/out 2>&1 <&- &" >> /tmp/bypass_oracle
echo "0 */2 * * * $(which speedtest-cli) --simple >> /root/speedtest.log 2>&1" >> /tmp/bypass_oracle
```

### Trên cấu hình Oracle VM.Standard.A1.Flex

Sau mỗi 12h sẽ tự sử dụng 20% CPU, tự chạy speedtest để sử dụng network, và tự sử dụng 5 GB RAM (24/24)

```
sudo wget --no-check-certificate https://raw.githubusercontent.com/bibicadotnet/NeverIdle-Oracle/master/VM.Standard.A1.Flex.sh -O /usr/local/bin/bypass_oracle.sh
```
```
chmod +x /usr/local/bin/bypass_oracle.sh
```
```
nohup /bin/bash /usr/local/bin/bypass_oracle.sh >> /root/out 2>&1 <&- &
```

Chạy crontab -e và dán:
```
echo "@reboot nohup /bin/bash /usr/local/bin/bypass_oracle.sh >> /root/out 2>&1 <&- &" >> /tmp/bypass_oracle
echo "0 */2 * * * $(which speedtest-cli) --simple >> /root/speedtest.log 2>&1" >> /tmp/bypass_oracle
```

Kiểm tra xem cron chạy chưa, chưa thì thêm vào

```
crontab -e
```

````
@reboot nohup /bin/bash /usr/local/bin/bypass_oracle.sh >> /root/out 2>&1 <&- &
0 */2 * * * /usr/bin/speedtest-cli --simple >> /root/speedtest.log 2>&1
````

Hoặc

```
@reboot nohup /bin/bash /usr/local/bin/bypass_oracle.sh >> /root/out 2>&1 <&- &
*/3 * * * * /usr/bin/speedtest-cli --simple >> /root/speedtest.log 2>&1
```




