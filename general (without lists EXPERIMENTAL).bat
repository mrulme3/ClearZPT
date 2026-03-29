@echo off
chcp 65001 > nul
:: 65001 - UTF-8

cd /d "%~dp0"
call service.bat status_zapret
echo:

set "BIN=%~dp0bin\"
set "LISTS=%~dp0lists\"
cd /d %BIN%

start "zapret: %~n0" /min "%bin%winws.exe" --wf-tcp=80,443,444-65535 --wf-udp=444-65535 ^
--filter-tcp=443 --dpi-desync=fake,split2 --dpi-desync-fake-tls-mod=none --dpi-desync-repeats=6 --dpi-desync-fooling=badseq,hopbyhop2 --dpi-desync-fake-tls="%BIN%tls_clienthello_www_google_com.bin" --new^
--filter-tcp=80 --dpi-desync=fake,split2 --dpi-desync-fake-tls-mod=none --dpi-desync-repeats=6 --dpi-desync-fooling=md5sig --dpi-desync-fake-tls="%BIN%tls_clienthello_www_google_com.bin" --new^
--filter-udp=444-65535 --dpi-desync=fake --dpi-desync-fake-tls-mod=none --dpi-desync-repeats=3 --dpi-desync-any-protocol=1 --dpi-desync-fake-unknown-udp="%BIN%quic_initial_www_google_com.bin" --dpi-desync-cutoff=n2