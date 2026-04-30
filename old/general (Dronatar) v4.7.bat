:: general (Dronatar)v4.6
:: Сделано Dronatar для «zapret-discord-youtube» версий 1.9.0 – 1.9.6 – ? (Обнолено до 4.7 Nazudestiny)
:: Ссылка на обсуждение: https://github.com/Flowseal/zapret-discord-youtube/discussions/3279

@echo off
title zapret: %~n0

cd /d "%~dp0"
chcp 65001 >nul
call service.bat status_zapret
call service.bat load_game_filter
call service.bat load_user_lists

set "BIN=%~dp0bin\"
set "LISTS=%~dp0lists\"
cd /d %BIN%

start "zapret: %~n0" /min "%BIN%winws.exe" --wf-tcp=80,443,853,2053,2083,2087,2096,8443,25565,%GameFilterTCP% --wf-udp=%GameFilterUDP%,53-65535 ^

--filter-udp=19294-19344,50000-50032 ^
--filter-l7=discord,stun ^
--dpi-desync=fake ^
--dpi-desync-fake-discord="%BIN%quic_initial_www_google_com.bin" ^
--dpi-desync-fake-stun="%BIN%quic_initial_www_google_com.bin" ^
--dpi-desync-repeats=6 --new ^

--filter-tcp=443,2053,2083,2087,2096,8443 --hostlist="%LISTS%list-general.txt" ^ 
--dpi-desync=fake ^
--dpi-desync-fake-tls-mod=sni=vk.me ^
--dpi-desync-fooling=badseq ^
--dpi-desync-badseq-increment=0 ^
--dpi-desync-badack-increment=1 ^
--dpi-desync-repeats=6 --new ^

--filter-udp=443 --hostlist="%LISTS%list-google.txt" --hostlist="%LISTS%list-general.txt" --hostlist="%LISTS%list-exclude-user.txt" ^
--dpi-desync=fake ^
--dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" ^
--dpi-desync-repeats=11 --new ^

--filter-tcp=80 --hostlist="%LISTS%list-google.txt" --hostlist="%LISTS%list-general.txt" --hostlist="%LISTS%list-exclude-user.txt" ^
--dpi-desync=fake ^
--dpi-desync-fake-http="%BIN%tls_clienthello_www_google_com.bin" ^
--dpi-desync-fooling=md5sig --new ^

--filter-tcp=443 --hostlist-exclude-domains=stable.dl2.discordapp.net --hostlist="%LISTS%list-google.txt" --hostlist="%LISTS%list-exclude-user.txt" ^
--dpi-desync=multidisorder ^
--dpi-desync-split-pos=1,midsld ^
--dpi-desync-split-seqovl=681 ^
--dpi-desync-split-seqovl-pattern="%BIN%4pda.bin" --new ^

--filter-tcp=443 --hostlist="%LISTS%list-general.txt" --hostlist="%LISTS%list-general-user.txt" --hostlist="%LISTS%list-exclude-user.txt" ^
--dpi-desync=fake,multisplit ^
--dpi-desync-split-pos=1,2,midsld ^
--dpi-desync-fake-tls-mod=rnd,dupsid,sni=vk.me ^
--dpi-desync-fooling=md5sig ^
--dpi-desync-repeats=6 --new ^

--filter-tcp=443,853 --hostlist="%LISTS%list-exclude-user.txt" ^
--dpi-desync=syndata ^
--dpi-desync-fake-syndata=0x00 ^
--dpi-desync-cutoff=n2 --new ^

--filter-tcp=80 --ipset="%LISTS%ipset-all.txt" ^
--dpi-desync=fake ^
--dpi-desync-fake-http="%BIN%4pda.bin" ^
--dpi-desync-fooling=badseq --new ^

--filter-tcp=443 --ipset="%LISTS%ipset-all.txt" ^
--dpi-desync=fake,multisplit ^
--dpi-desync-split-pos=1,2 ^
--dpi-desync-fake-tls-mod=none ^
--dpi-desync-fooling=md5sig ^
--dpi-desync-badseq-increment=0 ^
--dpi-desync-badack-increment=1 ^
--dpi-desync-repeats=6 --new ^

--filter-udp=443 --ipset="%LISTS%ipset-all.txt" ^
--dpi-desync=fake ^
--dpi-desync-repeats=6 --new ^

--filter-tcp=25565 --ipset-exclude="%LISTS%ipset-exclude.txt" ^
--dpi-desync-any-protocol=1 ^
--dpi-desync-cutoff=n5 ^
--dpi-desync=multisplit ^
--dpi-desync-split-seqovl=582 ^
--dpi-desync-split-pos=1 ^
--dpi-desync-split-seqovl-pattern="%BIN%tls_clienthello_4pda_to.bin" --new ^

--filter-tcp=%GameFilterTCP% --ipset="%LISTS%ipset-all.txt" ^
--dpi-desync-any-protocol ^
--dpi-desync=fakeknown,multisplit ^
--dpi-desync-fake-tls-mod=none ^
--dpi-desync-fooling=badseq ^
--dpi-desync-badseq-increment=0 ^
--dpi-desync-badack-increment=1 ^
--dpi-desync-split-pos=1 ^
--dpi-desync-split-seqovl=681 ^
--dpi-desync-split-seqovl-pattern="%BIN%tls_clienthello_www_google_com.bin" ^
--dpi-desync-cutoff=n3 ^
--dpi-desync-repeats=6 --new ^

--filter-udp=%GameFilterUDP% --ipset="%LISTS%ipset-all.txt" ^
--dpi-desync=fake ^
--dpi-desync-any-protocol ^
--dpi-desync-cutoff=n3 ^
--dpi-desync-repeats=12