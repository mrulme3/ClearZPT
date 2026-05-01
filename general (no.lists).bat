@echo off
:: 65001 - UTF-8

cd /d "%~dp0"
call service.bat status_zapret

set "BIN=%~dp0bin\"
set "LISTS=%~dp0lists\"

start "zapret: no lists" /min "%bin%winws.exe" --wf-tcp=80,443 --wf-udp=444-65535 ^

--filter-udp=19294-19344,50000-50100 ^
--filter-l7=discord,stun ^
--dpi-desync=fake ^
--dpi-desync-fake-discord="%BIN%quic_initial_dbankcloud_ru.bin" ^
--dpi-desync-fake-stun="%BIN%quic_initial_dbankcloud_ru.bin" ^
--dpi-desync-repeats=6 --new ^

--filter-tcp=443 ^
--dpi-desync=fake,split2 ^
--dpi-desync-fake-tls-mod=sni=vk.me ^
--dpi-desync-fooling=badseq,hopbyhop2 ^
--dpi-desync-badseq-increment=0 ^
--dpi-desync-badack-increment=1 ^
--dpi-desync-repeats=6 ^
--dpi-desync-fake-tls="%BIN%tls_clienthello_www_google_com.bin" --new ^

--filter-tcp=80 ^ 
--dpi-desync=fake,split2 ^
--dpi-desync-fake-tls-mod=sni=vk.me ^
--dpi-desync-repeats=6 ^
--dpi-desync-fooling=md5sig ^
--dpi-desync-fake-tls="%BIN%tls_clienthello_www_google_com.bin" --new ^

--filter-udp=444-19293,19345-49999,50033-65535 ^
--dpi-desync=fake ^
--dpi-desync-fake-tls-mod=sni=vk.me ^
--dpi-desync-repeats=3 ^
--dpi-desync-any-protocol=1 ^
--dpi-desync-fake-unknown-udp="%BIN%quic_initial_www_google_com.bin" ^
--dpi-desync-cutoff=n2

--filter-tcp=%GameFilterTCP%
--ipset="%LISTS%ipset-all.txt" 
--ipset-exclude="%LISTS%ipset-exclude.txt" 
--ipset-exclude="%LISTS%ipset-exclude-user.txt" 
--dpi-desync=fake,fakedsplit 
--dpi-desync-repeats=6 
--dpi-desync-any-protocol=1 
--dpi-desync-cutoff=n4 
--dpi-desync-fooling=ts 
--dpi-desync-fakedsplit-pattern=0x00 
--dpi-desync-fake-tls="%BIN%stun.bin" 
--dpi-desync-fake-tls="%BIN%tls_clienthello_www_google_com.bin" 
--dpi-desync-fake-http="%BIN%tls_clienthello_max_ru.bin" 
--new ^

--filter-udp=%GameFilterUDP% ^
--ipset="%LISTS%ipset-all.txt" ^
--ipset-exclude="%LISTS%ipset-exclude.txt" ^
--ipset-exclude="%LISTS%ipset-exclude-user.txt" ^
--dpi-desync=fake ^
--dpi-desync-repeats=10 ^
--dpi-desync-any-protocol=1 ^
--dpi-desync-fake-unknown-udp="%BIN%quic_initial_dbankcloud_ru.bin" ^
--dpi-desync-cutoff=n2