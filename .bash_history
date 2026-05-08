sudo apt update && sudo apt upgrade -y
exit
systemctl enable --now ssh
sudo apt update && sudo apt install -y openssh-server
wsl hostname -I
sudo apt install wsl
wsl hostname -I
sudo apt remove wsl
ip addr show eth0 | grep 'inet '
cat /etc/wsl.conf
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_*
chmod 644 ~/.ssh/*.pub
chmod 600 ~/.ssh/known_hosts
dpkg -l | grep -E "^ii" | awk '{print $2}' | grep -E "^(git|gh|ccache|python3|openjdk|build-essential|device-tree-compiler|bison|flex|libssl-dev|libelf-dev|lld|clang|llvm|binutils|aarch64)" | sort
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu noble stable" | sudo tee /etc/apt/sources.list.d/docker.list
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | sudo gpg --dearmor -o /usr/share/keyrings/vscodium-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg] https://download.vscodium.com/debs vscodium main" | sudo tee /etc/apt/sources.list.d/vscodium.list
sudo apt update && sudo apt upgrade
sudo apt install -y   git-lfs gh ccache   build-essential   device-tree-compiler   bison flex   libssl-dev libelf-dev   lld clang llvm   binutils-aarch64-linux-gnu   openjdk-11-jdk   bc zip unzip curl wget   libncurses-dev lib32ncurses-dev   lib32z1-dev lib32stdc++6   python3-dev python3-pip   schedtool rsync
sudo apt autoremove
sudo apt autopurge
sudo apt purge
sudo apt autoclean
sudo apt clean
exit
touch .hushlogin
netsh interface portproxy show all
uname -r
sudo apt install bc bison build-essential ccache curl flex g++-multilib   gcc-multilib git git-lfs gnupg gperf imagemagick lib32ncurses-dev   lib32readline-dev lib32z1-dev liblz4-tool libncurses6 libncurses-dev   libsdl1.2-dev libssl-dev libwxgtk3.2-dev libxml2 libxml2-utils lzop   pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev
chmod a+x ~/bin/repo
export PATH=~/bin:$PATH
cat .bashrc
exit
sudo sysctl vm.overcommit_memory=1
exit
cat /proc/meminfo | grep MemTotal
exit
exit
exit
exit
sudo service ssh stop
exit
service ssh status
exit
sudo apt
sudo apt search fetch
sudo apt install cpufetch
cpu fetch
sudo apt install h
neowofetch
sudo apt search biofetch
sudo apt install neofetch
sudo apt install screenfetch
cpufetch
hyfetch
neofetch
screenfetch
which ffprobe
la
exit
cd ..
..
cd home
cd blackshark
git remote add crdroid https://github.com/crdroidandroid/android_kernel_oneplus_sm8350.git
git fetch crdroid 16.0
git merge -s ours crdroid/16.0 -m "Sync history with upstream crDroid"
git push origin 16.0
git branch
git checkout -b 16.0
git remote set-url github git@github.com:bcrtvkcs/aesir_kernel_oneplus_sm8350.git
git push github 16.0
curl -LSs "https://raw.githubusercontent.com/bcrtvkcs/KernelSU-Next/refs/heads/legacy/kernel/setup.sh" | bash -s legacy
g a .
g cm -m "Sync history with upstream KernelSU-Next"
cat ~/.gitconfig | grep -A2 alias
grep "alias g" ~/.bashrc
cat ~/.gitconfig
git push --set-upstream github 16.0
git log --oneline -5
git log --oneline origin/legacy -5
git fetch origin
git status
git remote -v
git reset --hard origin/legacy
grep "alias synckernel" ~/.bashrc
cd ~/crDroid/kernel/oneplus/sm8350
git submodule status
git add KernelSU-Next
git cm -m "KernelSU-Next: update submodule to latest legacy"
g p
exit
cat README.md
cd KernelSU-Next
g st
exit
cd grepstein
l
chmod +x grepstein.sh
ex
sudo apt install httpie jq pdftotext
sudo apt install poppler-utils jq httpie
grepstein
grepstein a
exit
reposync
buildlemonadep
cmd.exe /c "echo %USERNAME%"
/mnt/c/Windows/System32/cmd.exe /c "echo %USERNAME%"
WIN_USER=$(/mnt/c/Windows/System32/cmd.exe /c "echo %USERNAME%" 2>/dev/null | tr -d '\r')
WIN_DOWNLOADS="/mnt/c/Users/${WIN_USER}/Downloads"
find "$HOME/crDroid/out/target/product/lemonadep" -maxdepth 1 -name "crDroidAndroid*.zip" -exec mv -v {} "$WIN_DOWNLOADS/" \;
exit
buildlemonade
cdkernel
cat changelog.md
synckernel
exit
service ssh start
sudo visudo
[200~echo "blackshark ALL=(ALL) NOPASSWD: /usr/sbin/service ssh start" | sudo tee -a /etc/sudoers.d/ssh-nopasswd
echo "blackshark ALL=(ALL) NOPASSWD: /usr/sbin/service ssh start" | sudo tee -a /etc/sudoers.d/ssh-nopasswd
sudo chmod 440 /etc/sudoers.d/ssh-nopasswd
exit
sudo service ssh start
shutdown
sed -i '/kc.sipahi@gmail.com/d' ~/.ssh/authorized_keys
cat ~/.ssh/authorized_keys
rm ~/.ssh/id_ed25519 ~/.ssh/id_ed25519.pub
ls ~/.ssh/
exit
hostname -I
cat /etc/sudoers.d/ssh-nopasswd
sudo cat /etc/sudoers.d/ssh-nopasswd
sudo service ssh status
exit
source ~/.bashrc
sudo cat /etc/wsl.conf
exit
crontab -l
cat /etc/crontab
ls -la /etc/cron.d/ && cat /etc/cron.d/*
ls /etc/cron.daily/ /etc/cron.weekly/ /etc/cron.monthly/ /etc/cron.hourly/
for user in $(cut -f1 -d: /etc/passwd); do echo "=== $user ==="; crontab -u $user -l 2>/dev/null; done
ls -la /usr/local/bin/update-ghostty.sh /usr/local/bin/update-claude.sh 2>/dev/null
find / -name "update-ghostty*" -o -name "update-claude*" 2>/dev/null
systemctl list-timers --all | grep -E "ghostty|claude"
buildlemonadep
ps aux | grep -E "make|ninja|soong"
alias | grep build
tmux attach -t buildlemonadep
tmux new -s yarrak
tmux attach -t yarrak
tmux list-windows
exit
....
pwd
nano desktop.ini
sudo nano desktop.ini
wsl --mount \\.\PhysicalDrive3 --bare
sudo mkdir -p /mnt/wsasys
ls /mnt/wsasys
sudo nano /mnt/wsasys/system/build.prop
sudo cp /mnt/wsasys/system/build.prop /tmp/build.prop.bak
sudo sed -i '/# extra props added by MagiskOnWSA/,$ d' /mnt/wsasys/system/build.prop
sudo sed -i 's/ro.product.system.brand=google/ro.product.system.brand=Android/' /mnt/wsasys/system/build.prop
sudo sed -i 's/ro.product.system.device=redfin/ro.product.system.device=generic/' /mnt/wsasys/system/build.prop
sudo sed -i 's/ro.product.system.manufacturer=Google/ro.product.system.manufacturer=Android/' /mnt/wsasys/system/build.prop
sudo sed -i 's/ro.product.system.model=Pixel 5/ro.product.system.model=mainline/' /mnt/wsasys/system/build.prop
sudo sed -i 's/ro.product.system.name=redfin/ro.product.system.name=mainline/' /mnt/wsasys/system/build.prop
sudo sed -i 's|ro.system.build.fingerprint=.*|ro.system.build.fingerprint=Windows/windows_x86_64/windows_x86_64:13/TQ3A.230901.001/2407.40000.4.0:user/release-keys|' /mnt/wsasys/system/build.prop
grep -E "ro.product.system|ro.system.build.fingerprint|MagiskOnWSA" /mnt/wsasys/system/build.prop
sudo cat /mnt/wsasys/system/build.prop | head -30
sudo cp /tmp/build.prop.bak /mnt/wsasys/system/build.prop
wc -c /tmp/build.prop.bak
sudo wc -c /tmp/build.prop.bak
sudo wc -c /mnt/wsasys/system/build.prop
sudo cp /mnt/wsasys/system/build.prop /home/blackshark/build.prop.edit
sudo chmod 666 /home/blackshark/build.prop.edit
sed -i '/# extra props added by MagiskOnWSA/,$ d' /home/blackshark/build.prop.edit
sed -i 's/ro.product.system.brand=google/ro.product.system.brand=Android/' /home/blackshark/build.prop.edit
sed -i 's/ro.product.system.device=redfin/ro.product.system.device=generic/' /home/blackshark/build.prop.edit
sed -i 's/ro.product.system.manufacturer=Google/ro.product.system.manufacturer=Android/' /home/blackshark/build.prop.edit
sed -i 's/ro.product.system.model=Pixel 5/ro.product.system.model=mainline/' /home/blackshark/build.prop.edit
sed -i 's/ro.product.system.name=redfin/ro.product.system.name=mainline/' /home/blackshark/build.prop.edit
sed -i 's|ro.system.build.fingerprint=.*|ro.system.build.fingerprint=Windows/windows_x86_64/windows_x86_64:13/TQ3A.230901.001/2407.40000.4.0:user/release-keys|' /home/blackshark/build.prop.edit
wc -c /home/blackshark/build.prop.edit
grep -E "ro.product.system|ro.system.build.fingerprint|MagiskOnWSA" /home/blackshark/build.prop.edit
sudo rm /mnt/wsasys/system/build.prop
sudo sync
sudo du -sh /mnt/wsasys/* | sort -rh | head -10
sudo du -sh /mnt/wsasys/system/* | sort -rh | head -10
sudo touch /mnt/wsasys/system/build.prop
sudo touch /mnt/wsasys/system/build.prop && echo "OK"
sudo e2fsck -f /dev/sde
sudo resize2fs /dev/sde
df -h /mnt/wsasys
sudo cp /home/blackshark/build.prop.edit /mnt/wsasys/system/build.prop && echo "OK"
sudo grep -E "ro.product.system|ro.system.build.fingerprint|MagiskOnWSA" /mnt/wsasys/system/build.prop
Mount-VHD -Path "C:\WSA\system.vhdx" -ReadOnly:$false
sudo mount -t erofs /dev/sde /mnt/wsasys 2>/dev/null || sudo mount -t ext4 /dev/sde /mnt/wsasys 2>/dev/null || dmesg | tail -5
sudo mount -t ext4 -o ro /dev/sde /mnt/wsasys
exit
sudo find /mnt/wsl/PhysicalDrive4 -name "*magisk*" -o -name "*Magisk*" 2>/dev/null
sudo mount -t ext4 -o ro /dev/sde /mnt/wsasys 2>/dev/null || sudo mount /dev/sde /mnt/wsasys
ls /mnt/wsl/
sudo mount -o ro /dev/sde /mnt/wsasys
sudo find /mnt/wsasys/data/adb -maxdepth 3 2>/dev/null
sudo cd /mnt/wsasys/data/adb
sudo find /mnt/wsasys -maxdepth 5 -name "*magisk*" 2>/dev/null
sudo ls /mnt/wsasys/data/ 2>/dev/null
sudo find /mnt/wsasys -name "*magiskinit*" -o -name "*magiskpolicy*" -o -name "magisk" 2>/dev/null
sudo find /mnt/wsasys -name "*magisk*" -o -name "*magisk*" -o -name "magisk" 2>/dev/null
sudo grep -r "magisk" /mnt/wsasys/system/etc/init/ 2>/dev/null
sudo ls /mnt/wsasys/system/etc/init/ | grep -i "magisk\|gapps\|google"
sudo find /mnt/wsasys -path "*/etc/init*" -type f 2>/dev/null | head -30
sudo ls /mnt/wsasys/system/ 2>/dev/null
sudo mount /dev/sde /mnt/wsasys && ls /mnt/wsasys/system/
sudo find /mnt/wsasys/system/etc/init -type f 2>/dev/null | head -30
sudo grep -rl "magisk" /mnt/wsasys/system/etc/init/ 2>/dev/null
sudo find /mnt/wsasys/system/bin /mnt/wsasys/system/lib64 /mnt/wsasys/system/apex -name "*magisk*" 2>/dev/null
sudo find /mnt/wsasys/system/priv-app /mnt/wsasys/system/app -name "*agisk*" -o -name "*Magisk*" 2>/dev/null
sudo find /mnt/wsasys/system/priv-app /mnt/wsasys/system/app
sudo ls /mnt/wsasys/system/product/ 2>/dev/null
sudo mount -o ro /dev/sde /mnt/wsasys 2>/dev/null || sudo mount -t ext4 -o ro /dev/sde /mnt/wsasys
sudo find /mnt/wsasys -name "*magisk*" -o -name "*Magisk*" 2>/dev/null
exit
strings /mnt/c/WSA/CustomInstall/WsaSetup.exe | grep -i magisk
Get-Content "C:\WSA\build.prop" | Select-String -Pattern "magisk"
strings /mnt/c/WSA/CustomInstall/WsaSetup.exe | head -50
strings /mnt/c/WSA/CustomInstall/WsaSetup.exe | grep -iE "apk|install|package|com\."
strings /mnt/c/WSA/CustomInstall/WsaSetup.exe | grep -iE "packageName|\.apk|magisk|com\.[a-z]"
sudo mount /dev/sde /mnt/wsasys
sudo grep -r "magisk\|WsaSetup\|CustomInstall" /mnt/wsasys/system/etc/ 2>/dev/null
sudo ls /mnt/wsasys/system/bin/init* 2>/dev/null
sudo ls /mnt/wsasys/
sudo file /mnt/wsasys/init
sudo file /mnt/wsasys/system/bin/init
sudo strings /mnt/wsasys/init | grep -i magisk
sudo strings /mnt/wsasys/system/bin/init | grep -i magisk
sudo find /mnt/wsasys/data/adb -maxdepth 4 2>/dev/null
sudo find /mnt/wsasys/data/app -maxdepth 3 -name "*magisk*" 2>/dev/null
sudo ls /mnt/wsasys/system/bin/ | grep -iE "init|magisk"
sudo xxd /mnt/c/WSA/CustomInstall/WsaSetup.exe | grep -i "PK" | head -5
binwalk /mnt/c/WSA/CustomInstall/WsaSetup.exe 2>/dev/null || sudo apt-get install -y binwalk
binwalk -e /mnt/c/WSA/CustomInstall/WsaSetup.exe -C /tmp/wsasetup_extracted/
ls /tmp/wsasetup_extracted/
dd if=/mnt/c/WSA/CustomInstall/WsaSetup.exe of=/tmp/payload.bin bs=1 skip=75492
dd if=/mnt/c/WSA/CustomInstall/WsaSetup.exe of=/tmp/payload.bin bs=1 skip=75492 count=100000
strings /tmp/payload.bin | grep -i magisk | head -20
cp /mnt/c/WSA/CustomInstall/WsaSetup.exe /tmp/WsaSetup.exe
strings /tmp/WsaSetup.exe | grep -iE "magisk|apk|install|package" | head -30
dd if=/tmp/WsaSetup.exe of=/tmp/wsa_xml.bin bs=1 skip=351187 count=5000
strings /tmp/wsa_xml.bin | head -50
import lzma, sys
data = open('/tmp/WsaSetup.exe', 'rb').read()
# Find LZMA magic bytes
pos = data.find(b'\xfd7zXZ')
if pos == -1:
    pos = data.find(b']\x00\x00')
print(f'LZMA offset: {pos} (0x{pos:x})')
"
import lzma
data = open('/tmp/WsaSetup.exe', 'rb').read()
payload = data[75036:]
try:
    out = lzma.decompress(payload)
    open('/tmp/extracted_payload', 'wb').write(out)
    print(f'Extracted {len(out)} bytes')
except Exception as e:
    print(f'Error: {e}')
"
import lzma
data = open('/tmp/WsaSetup.exe', 'rb').read()
payload = data[75036:]
try:
    out = lzma.decompress(payload, format=lzma.FORMAT_ALONE)
    open('/tmp/extracted_payload', 'wb').write(out)
    print(f'Extracted {len(out)} bytes')
except Exception as e:
    print(f'Error: {e}')
"
python3 -c "
import lzma
data = open('/tmp/WsaSetup.exe', 'rb').read()
for offset in [75556, 75492, 75036+64, 75036+5]:
    try:
        out = lzma.decompress(data[offset:], format=lzma.FORMAT_ALONE)
        open('/tmp/extracted_payload', 'wb').write(out)
        print(f'Success at offset {offset}, extracted {len(out)} bytes')
        break
    except Exception as e:
        print(f'Offset {offset}: {e}')
"
sudo apt-get install -y p7zip-full
7z e /tmp/WsaSetup.exe -o/tmp/wsa_7z/
ls /tmp/wsa_7z/
file /tmp/wsa_7z/1
strings /tmp/wsa_7z/1 | grep -iE "magisk|apk|package" | head -20
ls -la /tmp/wsa_7z/
strings /tmp/wsa_7z/.rdata | grep -iE "magisk|apk|package|\.apk" | head -20
cat /tmp/wsa_7z/version.txt
cat /tmp/wsa_7z/1
sudo umount /mnt/wsasys 2>/dev/null
sudo find /mnt/wsasys -type f 2>/dev/null
cat /mnt/wsasys/etc/init/init.windows_x86_64.rc
sudo find /mnt/wsasys -type f 2>/dev/null | grep -iE "magisk|apk" | head -20
sudo find /mnt/wsasys/priv-app /mnt/wsasys/app 2>/dev/null | head -40
wsl --unmount \\.\PhysicalDrive4
Dismount-VHD -Path "C:\WSA\product.vhdx"
lsbk
sudo find /mnt/wsasys/data -maxdepth 5 -iname "*magisk*" 2>/dev/null
sudo find /mnt/wsasys/data/app -maxdepth 3 2>/dev/null | head -30
lsblk
sudo mount /dev/sdd /mnt/wsasys
sudo mount -t ext4 -o ro /dev/sdd /mnt/wsasys
dmesg | tail -5
sudo umount /mnt/wsasys
cpio -it < /mnt/c/WSA/Tools/initrd.img 2>/dev/null | grep -i magisk
cpio -it < /mnt/c/WSA/Tools/initrd.img 2>/dev/null | head -30
file /mnt/c/WSA/Tools/initrd.img
xxd /mnt/c/WSA/Tools/initrd.img | head -5
cp /mnt/c/WSA/Tools/initrd.img /tmp/initrd.img
mkdir -p /tmp/initrd_extract
cpio -idm < /tmp/initrd.img 2>/dev/null
ls
sudo apt-get install -y cpio
sudo cpio -idmv < /tmp/initrd.img 2>&1 | head -20
ls -la /tmp/initrd_extract/
ls -la /tmp/initrd_extract/overlay.d/sbin/
sudo ls -la /tmp/initrd_extract/overlay.d/sbin/
sudo rm /tmp/initrd_extract/magiskinit
sudo rm /tmp/initrd_extract/overlay.d/sbin/magisk.xz
sudo rm /tmp/initrd_extract/overlay.d/sbin/stub.xz
sudo rm /tmp/initrd_extract/overlay.d/sbin/post-fs-data.sh
sudo ln -sfn wsainit /tmp/initrd_extract/init
cd /tmp/initrd_extract
sudo find . | sudo cpio -o -H newc > /tmp/initrd_new.img 2>/dev/null
file /tmp/initrd_new.img
ls -lh /tmp/initrd_new.img
cp /mnt/c/WSA/Tools/initrd.img /mnt/c/WSA/Tools/initrd.img.bak
cp /tmp/initrd_new.img /mnt/c/WSA/Tools/initrd.img
exiit
exit
sudo apt update && sudo apt install -y android-sdk-build-tools
find /usr -name "d8" 2>/dev/null
find /opt -name "d8" 2>/dev/null
which dx
find /usr -name "dx" 2>/dev/null
sudo apt remove -y android-sdk-build-tools android-sdk-build-tools-common aapt aidl android-libaapt android-libandroidfw android-libbacktrace android-libbase android-libcutils android-liblog android-libutils android-libziparchive apksigner libapksig-java libprotobuf32t64 libzopfli1 split-select zipalign
sudo apt autoremove -y
sudo apt install default-jdk
sudo apt install android-sdk
sdkmanager --list
sudo apt install google-android-cmdline-tools-11.0-installer
which d8
find / -name "d8" 2>/dev/null | grep -v proc
mkdir -p ~/wsa-audio-keepalive/module
import android.media.AudioManager;
import android.media.AudioTrack;
import android.media.AudioFormat;
public class AudioKeepalive {
    public static void main(String[] args) throws Exception {
        int sampleRate = 48000;
        int channelConfig = AudioFormat.CHANNEL_OUT_STEREO;
        int audioFormat = AudioFormat.ENCODING_PCM_16BIT;
        int bufferSize = AudioTrack.getMinBufferSize(sampleRate, channelConfig, audioFormat);
        if (bufferSize < 4800) bufferSize = 4800;
        AudioTrack track = new AudioTrack(
            AudioManager.STREAM_SYSTEM,
            sampleRate,
            channelConfig,
            audioFormat,
            bufferSize,
            AudioTrack.MODE_STREAM
        );
        track.setVolume(0.0f);
        track.play();
        byte[] silence = new byte[bufferSize];
        Runtime.getRuntime().addShutdownHook(new Thread(() -> {
            track.stop();
            track.release();
        }));
        while (!Thread.currentThread().isInterrupted()) {
            track.write(silence, 0, silence.length);
        }
    }
}
EOF
find / -path /mnt -prune -o -path /proc -prune -o -path /sys -prune -o -name "d8" -print 2>/dev/null
sudo nano /etc/wsl.conf
find /usr /opt -path /mnt -prune -o -name "android.jar" -print 2>/dev/null
find /usr/share -name "*.jar" 2>/dev/null | grep -i android | head -20
cd ~
wget https://dl.google.com/android/repository/platform-36_r01.zip
unzip platform-36_r01.zip 'android-36/android.jar'
ls android-36/android.jar
ls *.class
ls *.dex
mkdir -p ~/wsa-audio-keepalive/module/META-INF/com/google/android
cat > ~/wsa-audio-keepalive/module/module.prop << 'EOF'
id=wsa-audio-keepalive
name=WSA Audio Keepalive
version=v1.0
versionCode=1
author=bcrtvkcs
description=Prevents WSA AudioFlinger standby (fixes 500ms audio delay on resume)
EOF
cat > ~/wsa-audio-keepalive/module/META-INF/com/google/android/update-binary << 'EOF'
#!/sbin/sh
SKIPUNZIP=1
extract() { unzip -o "$ZIPFILE" "$1" -d "$MODPATH" >/dev/null 2>&1; }
ui_print() { echo "$1"; }
ui_print "- Installing WSA Audio Keepalive..."
mkdir -p "$MODPATH"
unzip -o "$ZIPFILE" 'audio_keepalive.dex' -d "$MODPATH" >/dev/null 2>&1
unzip -o "$ZIPFILE" 'service.sh' -d "$MODPATH" >/dev/null 2>&1
chmod 755 "$MODPATH/service.sh"
ui_print "- Done."
EOF
echo "#MAGISK" > ~/wsa-audio-keepalive/module/META-INF/com/google/android/updater-script
cat > ~/wsa-audio-keepalive/module/service.sh << 'EOF'
#!/system/bin/sh
# WSA Audio Keepalive - keeps AudioFlinger output stream alive
# Runs at boot via KernelSU/Magisk module service.sh
MODDIR=${0%/*}
# Wait for system to be fully booted
while [ "$(getprop sys.boot_completed)" != "1" ]; do
    sleep 2
done
sleep 5
# Run indefinitely - app_process will restart if killed
while true; do
    /system/bin/app_process \
        -Djava.class.path="$MODDIR/audio_keepalive.dex" \
        /system/bin \
        AudioKeepalive
    # If it crashes, wait 3s and restart
    sleep 3
done &
EOF
cp ~/wsa-audio-keepalive/classes.dex ~/wsa-audio-keepalive/module/audio_keepalive.dex
ls -la ~/wsa-audio-keepalive/module/
cd ~/wsa-audio-keepalive/module
ls -lh ../wsa-audio-keepalive.zip
cp ~/wsa-audio-keepalive/wsa-audio-keepalive.zip /mnt/c/Users/Administrator/Downloads/
exit
cd ~/wsa-audio-keepalive
cat > AudioKeepalive.java << 'EOF'
import android.media.AudioManager;
import android.media.AudioTrack;
import android.media.AudioFormat;
public class AudioKeepalive {
    public static void main(String[] args) throws Exception {
        int sampleRate = 48000;
        int channelConfig = AudioFormat.CHANNEL_OUT_STEREO;
        int audioFormat = AudioFormat.ENCODING_PCM_16BIT;
        int bufferSize = 4800;
        AudioTrack track = new AudioTrack(
            AudioManager.STREAM_SYSTEM,
            sampleRate,
            channelConfig,
            audioFormat,
            bufferSize,
            AudioTrack.MODE_STREAM
        );
        // Very low but non-zero volume - audible range starts ~0.01
        track.setVolume(0.003f);
        track.play();
        // Generate 15Hz sine wave
        byte[] buffer = new byte[bufferSize];
        double frequency = 15.0;
        for (int i = 0; i < bufferSize / 2; i++) {
            double sample = Math.sin(2.0 * Math.PI * frequency * i / sampleRate);
            short s = (short)(sample * 800); // low amplitude
            buffer[i * 2]     = (byte)(s & 0xFF);
            buffer[i * 2 + 1] = (byte)((s >> 8) & 0xFF);
        }
        Runtime.getRuntime().addShutdownHook(new Thread(() -> {
            track.stop();
            track.release();
        }));
        while (!Thread.currentThread().isInterrupted()) {
            track.write(buffer, 0, buffer.length);
        }
    }
}
EOF
javac -source 8 -target 8 -cp ~/android-36/android.jar AudioKeepalive.java
d8 --release --min-api 26 --output . AudioKeepalive.class
cp classes.dex module/audio_keepalive.dex
cd module
zip -r ../wsa-audio-keepalive.zip .
cp ../wsa-audio-keepalive.zip /mnt/c/Users/Administrator/Downloads/
exit
vsd
c
apt list --upgradable
apt list --upgradable -a
sudo apt install iproute2
exit
exit
exit
sudo visudo -f /etc/sudoers.d/apt-nopasswd
sudo ls /etc/sudoers.d/apt-nopasswd
sudo cat /etc/sudoers.d/apt-nopasswd
whoami
update
exit
