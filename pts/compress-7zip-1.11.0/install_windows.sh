#!/bin/sh
7z x 7z2405-extra.7z -aoa
chmod +x 7za.exe
echo "#!/bin/sh
./7za.exe b > \$LOG_FILE" > compress-7zip
chmod +x compress-7zip
