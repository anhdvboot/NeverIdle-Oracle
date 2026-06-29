# Bypass Oracle VM.Standard.E2.1.Micro 

Link gốc: https://gist.githubusercontent.com/Ansen/e45320205faf5786d3282ac880f20bab/raw/onekey-NeverIdle.sh

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
```
crontab -e
```

Thêm 

```
@reboot nohup /usr/local/bin/bypass_oracle.sh >> /root/out 2>&1 <&- &
0 */2 * * * /usr/bin/speedtest-cli --simple >> /root/speedtest.log 2>&1
```

Test thử

```
speedtest-cli --simple
```

Chạy lệnh

```
nohup /usr/local/bin/bypass_oracle.sh >> /root/out 2>&1 <&- &
```

Xem log

```
tail -f ~/speedtest.log
```

```
/usr/local/bin/bypass_oracle.sh
```

Sau mỗi 12h sẽ tự sử dụng 20% CPU, tự chạy speedtest 1 lần
```shell
sudo wget --no-check-certificate https://raw.githubusercontent.com/anhdvboot/NeverIdle-Oracle/refs/heads/main/VM.Standard.E2.1.Micro.sh -O /usr/local/bin/bypass_oracle.sh
chmod +x /usr/local/bin/bypass_oracle.sh
nohup /usr/local/bin/bypass_oracle.sh >> ./out 2>&1 <&- &
crontab -l > bypass_oracle
echo "@reboot nohup /usr/local/bin/bypass_oracle.sh >> /root/out 2>&1 <&- &" >> bypass_oracle
crontab bypass_oracle
```
# Bypass Oracle VM.Standard.A1.Flex
Sau mỗi 12h sẽ tự sử dụng 20% CPU, tự chạy speedtest 1 lần, và tự sử dụng 5GB RAM (24/24)
```shell
sudo wget --no-check-certificate https://raw.githubusercontent.com/anhdvboot/NeverIdle-Oracle/refs/heads/main/VM.Standard.A1.Flex.sh -O /usr/local/bin/bypass_oracle.sh
chmod +x /usr/local/bin/bypass_oracle.sh
nohup /usr/local/bin/bypass_oracle.sh >> ./out 2>&1 <&- &
crontab -l > bypass_oracle
echo "@reboot nohup /usr/local/bin/bypass_oracle.sh >> /root/out 2>&1 <&- &" >> bypass_oracle
crontab bypass_oracle
```
Chỉ sử dụng 5GB RAM (24/24)
```shell
sudo wget --no-check-certificate https://raw.githubusercontent.com/anhdvboot/NeverIdle-Oracle/refs/heads/main/VM.Standard.A1.Flex.4GB.RAM.sh -O /usr/local/bin/bypass_oracle.sh
chmod +x /usr/local/bin/bypass_oracle.sh
nohup /usr/local/bin/bypass_oracle.sh >> ./out 2>&1 <&- &
crontab -l > bypass_oracle
echo "@reboot nohup /usr/local/bin/bypass_oracle.sh >> /root/out 2>&1 <&- &" >> bypass_oracle
crontab bypass_oracle
```





