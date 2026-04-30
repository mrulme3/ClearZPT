@echo off
chcp 65001 > nul
:: 65001 - UTF-8

cd /d "%~dp0"
call service.bat status_zapret
call service.bat check_updates
call service.bat load_game_filter
call service.bat load_user_lists
echo:

set "BIN=%~dp0bin\"
set "LISTS=%~dp0lists\"
cd /d %BIN%

start "zapret" /min "%BIN%winws.exe" ^
--wf-tcp=80,443,25565,%GameFilter% ^
--wf-udp=443,%GameFilter% ^

--filter-tcp=25565 
--ipset-exclude="%LISTS%ipset-exclude.txt" 
--dpi-desync-any-protocol=1 
--dpi-desync-cutoff=n5 
--dpi-desync=multisplit 
--dpi-desync-split-seqovl=582 
--dpi-desync-split-pos=1 
--dpi-desync-split-seqovl-pattern="%BIN%tls_clienthello_4pda_to.bin" 
--new ^

--filter-udp=443 ^
--dpi-desync=fake ^
--dpi-desync-repeats=6 ^
--dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" ^
--new ^

--filter-tcp=443 ^
--dpi-desync=fake,multisplit ^
--dpi-desync-split-pos=1 ^
--dpi-desync-repeats=7 ^
--dpi-desync-fake-tls="%BIN%tls_clienthello_www_google_com.bin" ^
--new ^

--filter-tcp=80 ^
--dpi-desync=fake ^
--dpi-desync-repeats=6 ^
--dpi-desync-fake-http="%BIN%tls_clienthello_max_ru.bin" ^
--new ^

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

--filter-udp=%GameFilterUDP% 
--ipset="%LISTS%ipset-all.txt" 
--ipset-exclude="%LISTS%ipset-exclude.txt" 
--ipset-exclude="%LISTS%ipset-exclude-user.txt" 
--dpi-desync=fake 
--dpi-desync-repeats=12 
--dpi-desync-any-protocol=1 
--dpi-desync-fake-unknown-udp="%BIN%quic_initial_www_google_com.bin" 
--dpi-desync-cutoff=n3
