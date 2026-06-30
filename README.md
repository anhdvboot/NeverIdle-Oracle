# Bypass Oracle VM.Standard.E2.1.Micro 

Link gốc: https://gist.githubusercontent.com/Ansen/e45320205faf5786d3282ac880f20bab/raw/onekey-NeverIdle.sh

Nên dùng tham cố -cp 0.3 để luôn chạy 30% nếu vps chưa làm gì

Với E21 Micro (bỏ qua -n 2h nếu speedtest lỗi)

```
-cp 0.3 -n 2h
```

Với Flex (bỏ qua -n 2h nếu speedtest lỗi)

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


Chạy lệnh

```
nohup /bin/bash /usr/local/bin/bypass_oracle.sh >> /root/out 2>&1 <&- &
```

Xem log

```
tail -f ~/speedtest.log
```


### Trên cấu hình Oracle VM.Standard.E2.1.Micro

Sau mỗi 12h sẽ tự sử dụng 20% CPU, tự chạy speedtest 1 lần để sử dụng network

```
sudo wget --no-check-certificate https://raw.githubusercontent.com/anhdvboot/NeverIdle-Oracle/refs/heads/main/VM.Standard.E2.1.Micro.sh
```
```
chmod +x /usr/local/bin/bypass_oracle.sh
```
```
nohup /bin/bash /usr/local/bin/bypass_oracle.sh >> /root/out 2>&1 <&- &
```

Tạo file speedtest qua cloudflare

```
cat > /root/speedtest.sh << 'EOF'
#!/bin/bash
SPEED=$(curl -o /dev/null -s -w "%{speed_download}" https://speed.cloudflare.com/__down?bytes=50000000)
echo "$(date '+%Y-%m-%d %H:%M:%S') - Speed: $(echo $SPEED | awk '{printf "%.2f", $1/125000}') Mbit/s" >> /root/speedtest.log
EOF
chmod +x /root/speedtest.sh
```

Tạo cron:
```
cat > /tmp/mycron << 'EOF'
SHELL=/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
HOME=/root

@reboot nohup /usr/local/bin/bypass_oracle.sh >> /root/out 2>&1 <&- &
0 */1 * * * /root/speedtest.sh
EOF
crontab /tmp/mycron
```

### Trên cấu hình Oracle VM.Standard.A1.Flex

Sau mỗi 12h sẽ tự sử dụng 20% CPU, tự chạy speedtest để sử dụng network, và tự sử dụng 5 GB RAM (24/24)

```
sudo wget --no-check-certificate https://raw.githubusercontent.com/anhdvboot/NeverIdle-Oracle/refs/heads/main/VM.Standard.A1.Flex.sh
```
```
chmod +x /usr/local/bin/bypass_oracle.sh
```
```
nohup /bin/bash /usr/local/bin/bypass_oracle.sh >> /root/out 2>&1 <&- &
```

Tạo file speedtest qua cloudflare

```
cat > /root/speedtest.sh << 'EOF'
#!/bin/bash
SPEED=$(curl -o /dev/null -s -w "%{speed_download}" https://speed.cloudflare.com/__down?bytes=50000000)
echo "$(date '+%Y-%m-%d %H:%M:%S') - Speed: $(echo $SPEED | awk '{printf "%.2f", $1/125000}') Mbit/s" >> /root/speedtest.log
EOF
chmod +x /root/speedtest.sh
```

Tạo cron:
```
cat > /tmp/mycron << 'EOF'
SHELL=/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
HOME=/root

@reboot nohup /usr/local/bin/bypass_oracle.sh >> /root/out 2>&1 <&- &
0 */1 * * * /root/speedtest.sh
EOF
crontab /tmp/mycron
```

Kiểm tra xem cron đúng chưa

```
crontab -l
```


Hoặc

```
SHELL=/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
HOME=/root

@reboot nohup /usr/local/bin/bypass_oracle.sh >> /root/out 2>&1 <&- &
*/2 * * * * /root/speedtest.sh
```




