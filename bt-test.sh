aria2c -V --seed-ratio=0.0 artifacts/*.torrent -dartifacts/ --enable-dht6 --enable-dht  --bt-seed-unverified=true -j32 \
--bt-tracker=udp://tracker.opentrackr.org:1337/announce,udp://tracker.torrent.eu.org:451/announce
