#!/bin/bash
#From: http://pbxinaflash.com/community/threads/skype-4-3-with-freeswitch-no-sound.15393/
#    Instructions for Ubuntu server 10.04 32 bit with old skypopen installed.

# Install the latest Skype client
# NOTE: DYNAMIC client recommended therefore root access is necessary to install it and its required libraries.
cd /tmp
wget http://download.skype.com/linux/skype-4.3.0.37.tar.bz2
tar xjvf /tmp/skype-4.3.0.37.tar.bz2 -C /usr/local
rm /tmp/skype-4.3.0.37.tar.bz2
ln -s /usr/local/skype-4.3.0.37 /usr/local/skype
ln -s /usr/local/skype /usr/share/skype
ln -s /usr/local/skype/skype /usr/local/bin/skype

#    note: new Skype client need pulseaudio!
apt-get install libx11-dev libx11-dev libxau-dev libxcb1-dev libxdmcp-dev x11proto-core-dev x11proto-input-dev x11proto-kb-dev xtrans-dev
apt-get install libxss1 libqtcore4 libqt4-dbus libqtgui4
apt-get install python-software-properties
add-apt-repository ppa:kubuntu-ppa/backports
apt-get update
apt-get install libqt4-webkit
apt-get install xvfb
apt-get install libasound2 libasound2-plugins alsa alsa-utils alsa-oss alsa-tools
apt-get install pulseaudio pulseaudio-utils

# Additional packages and specific details from :
# https://wiki.centos.org/HowTos/Skype

#    Hello Guys,
#
#    Recently I found this list where you can find how to fix the Skype bridge for Freeswitch using Skype 4.3 version. Its really hard to test in production server but it works.
#
#    http://permalink.gmane.org/gmane.comp.telephony.freeswitch.user/72343
#
#    I hope this help you guys.
#
#    Luis
#8
#Luis Ojeda, Aug 28, 2014 

#From: https://wiki.centos.org/HowTos/Skype
yum update
yum groupinstall Desktop

# FROM Giovanni Maruzzelli aricle on comp.telephony.freeswitch.user
#http://permalink.gmane.org/gmane.comp.telephony.freeswitch.user/72343
# CentOS 6.5 packages to be installed:
# Dependencies for building mod_skypopen:
yum install libX11-devel
# Infrastructure needed to run skype client:
yum install pulseaudio Xvfb xorg-x11-fonts* xz pulseaudio-utils
# Dependencies of skype client:
# Enable libraries repo
yum localinstall http://download.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
# Install libraries
yum install qt-x11.i686 qtwebkit.i686 glibc.i686  libgcc.i686 libstdc++.i686 libXv.i686 \
 libX11.i686 libXext.i686 libXScrnSaver.i686 libcanberra-gtk2.i686 \
 gtk2-engines.i686 PackageKit-gtk-module.i686

#From: https://wiki.centos.org/HowTos/Skype
yum update
yum groupinstall Desktop
yum install qtwebkit.i686 webkitgtk.i686
yum install alsa-lib.i686 libXv.i686 libXScrnSaver.i686 gtk2-engines.i686 \
 PackageKit-gtk-module.i686 libcanberra.i686 libcanberra-gtk2.i686
yum install pulseaudio-libs.i686 alsa-plugins-pulseaudio.i686
yum install libv4l.i686

# For 64 bit CentOS, Then, to run Skype, load the 32-bit v4l1compat.so:
# [user@host]$ LD_PRELOAD=/usr/lib/libv4l/v4l1compat.so /opt/skype/skype

# 1.4. Adding skype.desktop to Desktops
#If you want to have skype.desktop to show up on users desktops, you need to edit the file /usr/share/skype/skype.desktop and search for the line that says:
#Icon=skype.png
#and change it too
#Icon=/usr/share/skype/icons/SkypeBlue_48x48.png
#then copy the skype.desktop file into the user(s) Desktop with the command:
#[root@host]# cp -a /usr/share/skype/skype.desktop ~<username>/Desktop
#[root@host]# chown <username> ~<username>/Desktop/skype.desktop

#1.5. Running Skype
#You can run the skype program (as a normal user) from the command line with the command:
#[user@host]$ skype
#Also, if you installed the skype.desktop file above, you should be able to double click it from your desktop.

# edit
#    /lib/linux-sound-base/noALSA.nodprobe.conf
#    and
#    /lib/linux-sound-base/noOSS.nodprobe.conf
#    and remove everything inside (empty files)
cat <<EOF > /lib/linux-sound-base/noALSA.nodprobe.conf

EOF
cat <<EOF > /lib/linux-sound-base/noOSS.nodprobe.conf

EOF

#    Pulseaudio configuration (Centos / Ubuntu)
#    add root (or freeswitch) user to group pulseaudio and pulse-access
groupadd pulseaudio
groupadd pulse-access
usermod -a -G pulseaudio freeswitch
usermod -a -G pulse-access freeswitch
usermod -a -G pulseaudio root
usermod -a -G pulse-access root

#    nano /etc/default/pulseaudio
#    Change
#    PULSEAUDIO_SYSTEM_START=0
#    to
#    PULSEAUDIO_SYSTEM_START=1

#    nano /etc/pulse/system.pa
#    remove everything and put
cat <<EOF > /etc/pulse/system.pa
load-module module-null-sink
load-module module-native-protocol-unix
EOF

#    nano /etc/pulse/daemon.conf
#    at the end of the file add
cat <<EOF >> /etc/pulse/daemon.conf
daemonize = yes
system-instance = yes
resample-method = trivial
flat-volumes = yes
default-sample-rate = 48000
default-sample-channels = 1
default-fragment-size-msec = 20
; alternate-sample-rate = 44100
EOF

#    nano /etc/init.d/pulseaudio

mv /etc/init.d/pulseaudio /root/pulseaudio.initscript.bak

#    remove everything and put the following lines
#    Code:
cat <<EOF > /etc/init.d/pulseaudio
#!/bin/sh -e
### BEGIN INIT INFO
# Provides: pulseaudio esound
# Required-Start: $remote_fs $syslog
# Required-Stop: $remote_fs $syslog
# Should-Start: udev NetworkManager
# Should-Stop: udev NetworkManager
# Default-Start: 2 3 4 5
# Default-Stop: 1
# Short-Description: Start the PulseAudio sound server
# Description: System mode startup script for
# the PulseAudio sound server.
### END INIT INFO
DAEMON=/usr/bin/pulseaudio
PIDDIR=/var/run/pulse
PIDFILE=$PIDDIR/pid
DAEMONUSER=pulse
PATH=/sbin:/bin:/usr/sbin:/usr/bin
test -x $DAEMON || exit 0
. /lib/lsb/init-functions
PULSEAUDIO_SYSTEM_START=0
DISALLOW_MODULE_LOADING=1
test -f /etc/default/pulseaudio && . /etc/default/pulseaudio
if [ "$PULSEAUDIO_SYSTEM_START" != "1" ]; then
  log_warning_msg "PulseAudio configured for per-user sessions"
  exit 0
fi
pulseaudio_start () {
  log_daemon_msg "Starting system PulseAudio Daemon"
  if [ ! -d $PIDDIR ]; then
    mkdir -p $PIDDIR
    chown $DAEMONUSER:$DAEMONUSER $PIDDIR
  fi
  start-stop-daemon -x $DAEMON -p $PIDFILE --start -- --system --daemonize --log-
  target=syslog --disallow-module-loading=$DISALLOW_MODULE_LOADING
  status=$?
  if [ -e /var/run/pulse/.esd_auth ]; then
    chown pulse:pulse-access /var/run/pulse/.esd_auth
    chmod 640 /var/run/pulse/.esd_auth
  fi
  if [ -e /var/run/pulse/.pulse-cookie ]; then
    chown pulse:pulse-access /var/run/pulse/.pulse-cookie
    chmod 640 /var/run/pulse/.pulse-cookie
  fi
  log_end_msg ${status}
}
pulseaudio_stop () {
  log_daemon_msg "Stopping system PulseAudio Daemon"
  start-stop-daemon -p $PIDFILE --stop --retry 5 || echo -n "...which is not running"
  log_end_msg $?
}
case "$1" in
  start|stop)
    pulseaudio_${1}
    ;;
  restart|reload|force-reload)
    if [ -s $PIDFILE ] && kill -0 $(cat $PIDFILE) >/dev/null 2>&1; then
      pulseaudio_stop
      pulseaudio_start
    fi
    ;;
  force-stop)
    pulseaudio_stop
    killall pulseaudio || true
    sleep 2
    killall -9 pulseaudio || true
    ;;
  status)
    status_of_proc -p $PIDFILE "$DAEMON" "system-wide PulseAudio" && exit 0 ||
    exit $?
    ;;
  *)
    echo "Usage: /etc/init.d/pulseaudio {start|stop|force-stop|restart|reload|force-reload|
    status}"
    exit 1
    ;;
 esac
 exit 0
EOF

#    nano /usr/local/freeswitch/skypopen/skype-clients-startup-dir/start_skype_clients.sh

#    check if you have the following lines

#    Code:

#!/bin/sh
#Unload possible ALSA sound modules that would conflict with our OSS fake module
rmmod snd_pcm_oss
rmmod snd_mixer_oss
rmmod snd_seq_oss
sleep 1
     
#Create the inode our fake sound driver will use
mknod /dev/dsp c 14 3
     
#Load our OSS fake module
insmod /usr/local/freeswitch/skypopen/skypopen-sound-driver-dir/skypopen.ko
pulseaudio -D
     
#start the fake X server on the given port
/usr/bin/Xvfb :101 -ac -nolisten tcp -screen 0 640x480x8 &
sleep 3
     
# start a Skype client instance that will connect to the X server above, and will login to the Skype network using the 'username password' you send to it on stdin.
su root -c "/bin/echo 'SkypeUser SkypePass'| DISPLAY=:101  /usr/local/freeswitch/skypopen/skype-clients-symlinks-dir/skype101 --dbpath=/usr/local/freeswitch/skypopen/skype-clients-configuration-dir/skype101 --pipelogin &"
sleep 7
exit 0

#    tested on two Asterisk 1.6.2.4 + FreePBX 2.8.1.5 + Freeswitch 1.2.10 PBXes
##10
#pilovis, Sep 26, 2014 
