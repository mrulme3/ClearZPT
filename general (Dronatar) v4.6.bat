:: general (Dronatar)v4.6
:: Сделано Dronatar для «zapret-discord-youtube» версий 1.9.0 – 1.9.6 – ?
:: Ссылка на обсуждение: https://github.com/Flowseal/zapret-discord-youtube/discussions/3279

:: Метка [WIP] означает, что профиль недостаточно проверен или не завершён.

@echo off
title zapret: %~n0

cd /d "%~dp0"
chcp 65001 >nul
call service.bat status_zapret
net session >nul 2>&1
if %errorLevel% == 0 (echo Запуск...) else (echo Требуются права администратора...)
call service.bat load_game_filter
call service.bat load_user_lists

set "BIN=%~dp0bin\"
set "LISTS=%~dp0lists\"
cd /d %BIN%

start "zapret: %~n0" /min "%BIN%winws.exe" --wf-tcp=80,443,853,2053,2083,2087,2096,8443,25565,%GameFilter% --wf-udp=%GameFilter%,53-65535 ^

--comment Telegram (WebRTC) [WIP] --filter-udp=1400 --filter-l7=stun --dpi-desync=fake --dpi-desync-fake-stun=0x00 --new ^

--comment WhatsApp (WebRTC) [WIP] --filter-udp=3478-3482,3484,3488,3489,3491-3493,3495-3497 --filter-l7=stun --dpi-desync=fake --dpi-desync-fake-stun=0x00 --dpi-desync-repeats=6 --new ^

--comment Discord (WebRTC) --filter-udp=19294-19344,50000-50032 --filter-l7=discord,stun --dpi-desync=fake --dpi-desync-fake-discord="%BIN%quic_initial_www_google_com.bin" --dpi-desync-fake-stun="%BIN%quic_initial_www_google_com.bin" --dpi-desync-repeats=6 --new ^

--comment Discord --filter-tcp=443,2053,2083,2087,2096,8443 --hostlist-domains=dis.gd,discord-attachments-uploads-prd.storage.googleapis.com,discord.app,discord.co,discord.com,discord.design,discord.dev,discord.gift,discord.gifts,discord.gg,gateway.discord.gg,discord.media,discord.new,discord.store,discord.status,discord-activities.com,discordactivities.com,discordapp.com,cdn.discordapp.com,discordapp.net,media.discordapp.net,images-ext-1.discordapp.net,updates.discord.com,stable.dl2.discordapp.net,discordcdn.com,discordmerch.com,discordpartygames.com,discordsays.com,discordsez.com,discordstatus.com --dpi-desync=fake --dpi-desync-fake-tls-mod=sni=vk.me --dpi-desync-fooling=badseq --dpi-desync-badseq-increment=0 --dpi-desync-badack-increment=1 --dpi-desync-repeats=6 --new ^

--comment list-google(YouTube QUIC)/list-general(QUIC) --filter-udp=443 --hostlist="%LISTS%list-google.txt" --hostlist="%LISTS%list-general.txt" --dpi-desync=fake --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --dpi-desync-repeats=11 --new ^

--comment list-google(YouTube Streaming)/list-general(HTTP) --filter-tcp=80 --hostlist="%LISTS%list-google.txt" --hostlist="%LISTS%list-general.txt" --dpi-desync=fake --dpi-desync-fake-http="%BIN%tls_clienthello_www_google_com.bin" --dpi-desync-fooling=badseq --new ^

--comment list-google(YouTube) --filter-tcp=443 --hostlist-exclude-domains=stable.dl2.discordapp.net --hostlist="%LISTS%list-google.txt" --dpi-desync=multidisorder --dpi-desync-split-pos=1,midsld --dpi-desync-split-seqovl=681 --dpi-desync-split-seqovl-pattern="%BIN%tls_clienthello_www_google_com.bin" --new ^

--comment list-general+Extras --filter-tcp=443 --hostlist-exclude-domains=dis.gd,discord-attachments-uploads-prd.storage.googleapis.com,discord.app,discord.co,discord.com,updates.discord.com,discord.design,discord.dev,discord.gift,discord.gifts,discord.gg,gateway.discord.gg,discord.media,discord.new,discord.store,discord.status,discord-activities.com,discordactivities.com,discordapp.com,cdn.discordapp.com,discordapp.net,media.discordapp.net,images-ext-1.discordapp.net,discordcdn.com,discordmerch.com,discordpartygames.com,discordsays.com,discordsez.com,discordstatus.com --hostlist="%LISTS%list-general.txt" --hostlist-domains=adguard.com,adguard-vpn.com,totallyacdn.com,whiskergalaxy.com,windscribe.com,windscribe.net,soundcloud.com,sndcdn.com,soundcloud.cloud,nexusmods.com,nexus-cdn.com,prostovpn.org,html-classic.itch.zone,html.itch.zone,speedtest.net,softportal.com,ntc.party,mega.co.nz,modrinth.com,forgecdn.net,minecraftforge.net,neoforged.net,essential.gg,imagedelivery.net,malw.link,cloudflare-gateway.com,quora.com,amazon.com,awsstatic.com,amazonaws.com,awsapps.com,roblox.com,rbxcdn.com,whatsapp.com,whatsapp.net,uploads.ungrounded.net,tesera.io,roskomsvoboda.org,github-api.arkoselabs.com,anydesk.my.site.com,totalcommander.ch --dpi-desync=fake,multisplit --dpi-desync-fake-tls-mod=rnd,dupsid,sni=vk.me --dpi-desync-split-pos=1,host --dpi-desync-fooling=badseq --dpi-desync-badseq-increment=0 --dpi-desync-badack-increment=1 --dpi-desync-repeats=6 --new ^

--comment Cloudflare WARP Gateway(1.1.1.1, 1.0.0.1) --filter-tcp=443,853 --ipset-ip=162.159.36.1,162.159.46.1,2606:4700:4700::1111,2606:4700:4700::1001 --dpi-desync=syndata --dpi-desync-fake-syndata=0x00 --dpi-desync-cutoff=n2 --new ^

--comment WireGuard handshake --filter-udp=53-65535 --filter-l7=wireguard --dpi-desync=fake --dpi-desync-fake-wireguard="%BIN%quic_initial_www_google_com.bin" --dpi-desync-cutoff=n2 --dpi-desync-repeats=4 --new ^

--comment Roblox(UDP) [WIP] --filter-udp=49152-65535 --ipset-ip=103.140.28.0/23,128.116.0.0/17,141.193.3.0/24,205.201.62.0/24,2620:2b:e000::/48,2620:135:6000::/40,2620:135:6004::/48,2620:135:6007::/48,2620:135:6008::/48,2620:135:6009::/48,2620:135:600a::/48,2620:135:600b::/48,2620:135:600c::/48,2620:135:600d::/48,2620:135:600e::/48,2620:135:6041::/48 --dpi-desync=fake --dpi-desync-fake-unknown-udp=0x00 --dpi-desync-any-protocol --dpi-desync-cutoff=n2 --new ^

--comment IP set(TCP 80) --filter-tcp=80 --ipset="%LISTS%ipset-all.txt" --dpi-desync=fake --dpi-desync-fake-http="%BIN%tls_clienthello_www_google_com.bin" --dpi-desync-fooling=badseq --new ^

--comment IP set(TCP 443) --filter-tcp=443 --ipset="%LISTS%ipset-all.txt" --dpi-desync=fake,multisplit --dpi-desync-fake-tls-mod=none --dpi-desync-fooling=badseq --dpi-desync-badseq-increment=0 --dpi-desync-badack-increment=1 --dpi-desync-split-pos=1 --dpi-desync-repeats=6 --new ^

--comment IP set(UDP 443) --filter-udp=443 --ipset="%LISTS%ipset-all.txt" --dpi-desync=fake --dpi-desync-repeats=6 --new ^

--comment IP set(25565) --filter-tcp=25565 --ipset-exclude="%LISTS%ipset-exclude.txt" --dpi-desync-any-protocol=1 --dpi-desync-cutoff=n5 --dpi-desync=multisplit --dpi-desync-split-seqovl=582 --dpi-desync-split-pos=1 --dpi-desync-split-seqovl-pattern="%BIN%tls_clienthello_4pda_to.bin" --new ^

--comment Games(TCP) --filter-tcp=%GameFilter% --ipset="%LISTS%ipset-all.txt" --dpi-desync-any-protocol --dpi-desync=fakeknown,multisplit --dpi-desync-fake-tls-mod=none --dpi-desync-fooling=badseq --dpi-desync-badseq-increment=0 --dpi-desync-badack-increment=1 --dpi-desync-split-pos=1 --dpi-desync-split-seqovl=681 --dpi-desync-split-seqovl-pattern="%BIN%tls_clienthello_www_google_com.bin" --dpi-desync-cutoff=n3 --dpi-desync-repeats=6 --new ^

--comment Games(UDP) --filter-udp=%GameFilter% --ipset="%LISTS%ipset-all.txt" --dpi-desync=fake --dpi-desync-any-protocol --dpi-desync-cutoff=n3 --dpi-desync-repeats=12