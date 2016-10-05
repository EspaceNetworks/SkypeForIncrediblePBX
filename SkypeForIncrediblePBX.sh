#!/bin/bash
#From: http://pbxinaflash.com/community/threads/skype-4-3-with-freeswitch-no-sound.15393/
#    Instructions for Ubuntu server 10.04 32 bit with old skypopen installed.
# CentOS added 4 Oct 2016 by ESPACE LLC.
# From: https://wiki.centos.org/HowTos/Skype
# Starting with Aug 4th 2014, no version of Skype older than 4.3 works due to the changes
# that were implemented in the authentication mechanism. Any attempt to use older versions
# lead to an error message similar to "Cannot contact server" ( the exact message varies 
# depending on the version that was used ). 

# Install the latest Skype dynamic client
# NOTE: DYNAMIC client recommended therefore requires root access to install skype and system libraries.
install_skype_client()
{
  cd /tmp
  wget http://download.skype.com/linux/skype-4.3.0.37.tar.bz2
  tar xjvf /tmp/skype-4.3.0.37.tar.bz2 -C /usr/local
  rm /tmp/skype-4.3.0.37.tar.bz2
  ln -s /usr/local/skype-4.3.0.37 /usr/local/skype
  ln -s /usr/local/skype /usr/share/skype
  ln -s /usr/local/skype/skype /usr/local/bin/skype
}

install_prereq_debian()
{
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
}

install_prereq_debian_7_skypopen()
{
# Dependencies for building mod_skypopen:
 apt-get install libx11-dev libx11-dev libxau-dev libxcb1-dev libxdmcp-dev \
 x11proto-core-dev x11proto-input-dev x11proto-kb-dev xtrans-dev

 # Infrastructure needed to run skype client:
 apt-get install xvfb pulseaudio

 # Dependencies of skype client:
 # Enable i386 libraries installing
 dpkg --add-architecture i386
 apt-get update
 # Install libraries
 apt-get install \
 fontconfig fontconfig-config gcc-4.7-base:i386 libasound2:i386 \
 libasound2-plugins:i386 libasyncns0:i386 libattr1:i386 libaudio2:i386 \
 libavahi-client3:i386 libavahi-common-data:i386 libavahi-common3:i386 \
 libavcodec53:i386 libavutil51:i386 libc6:i386 libc6-i686:i386 libcap2:i386 \
 libcomerr2:i386 libcups2:i386 libdbus-1-3:i386 libdirac-encoder0:i386 \
 libexpat1:i386 libffi5:i386 libflac8:i386 libfontconfig1 libfontconfig1:i386 \
 libfreetype6:i386 libgcc1:i386 libgcrypt11:i386 libglib2.0-0:i386 \
 libgnutls26:i386 libgpg-error0:i386 libgsm1:i386 libgssapi-krb5-2:i386 \
 libgstreamer-plugins-base0.10-0:i386 libgstreamer0.10-0:i386 libice6:i386 \
 libjack-jackd2-0:i386 libjbig0:i386 libjpeg8:i386 libjson0:i386 \
 libk5crypto3:i386 libkeyutils1:i386 libkrb5-3:i386 libkrb5support0:i386 \
 liblcms1:i386 liblzma5:i386 libmng1:i386 libmp3lame0:i386 libogg0:i386 \
 libopenjpeg2:i386 liborc-0.4-0:i386 libp11-kit0:i386 libpcre3:i386 \
 libpng12-0:i386 libpulse0:i386 libqt4-dbus:i386 libqt4-network:i386 \
 libqt4-xml libqt4-xml:i386 libqtcore4 libqtcore4:i386 libqtdbus4 \
 libqtdbus4:i386 libqtgui4:i386 libqtwebkit4:i386 libsamplerate0:i386 \
 libschroedinger-1.0-0:i386 libselinux1:i386 libsm6:i386 libsndfile1:i386 \
 libspeex1:i386 libspeexdsp1:i386 libsqlite3-0:i386 libssl1.0.0:i386 \
 libstdc++6:i386 libtasn1-3:i386 libtheora0:i386 libtiff4:i386 libuuid1:i386 \
 libva1:i386 libvorbis0a:i386 libvorbisenc2:i386 libvpx1:i386 libwrap0:i386 \
 libx11-6:i386 libx11-xcb1:i386 libx264-123:i386 libxau6:i386 libxcb1:i386 \
 libxdmcp6:i386 libxext6:i386 libxi6:i386 libxml2:i386 libxrender1:i386 \
 libxss1:i386 libxt6:i386 libxtst6:i386 libxv1:i386 libxvidcore4:i386 qdbus\
 ttf-dejavu-core uuid-runtime zlib1g:i386
}

install_prereq_ubuntu_14_skypopen()
{
#In addition to the packages required to build and run FreeSWITCH, we
#need the following:

 # Dependencies for building mod_skypopen:
 apt-get install \
 libx11-dev libx11-dev libxau-dev libxcb1-dev libxdmcp-dev \
 x11proto-core-dev x11proto-input-dev x11proto-kb-dev xtrans-dev

 # Infrastructure needed to run skype client:
 apt-get install \
 xvfb pulseaudio

 # Dependencies of skype client:
 apt-get install \
 fontconfig fontconfig-config gcc-4.7-base:i386 libasound2:i386 \
 libasound2-plugins:i386 libasyncns0:i386 libattr1:i386 libaudio2:i386 \
 libavahi-client3:i386 libavahi-common-data:i386 libavahi-common3:i386 \
 libavcodec53:i386 libavutil51:i386 libc6:i386 libc6-i686:i386 libcap2:i386 \
 libcomerr2:i386 libcups2:i386 libdbus-1-3:i386 libdirac-encoder0:i386 \
 libexpat1:i386 libffi5:i386 libflac8:i386 libfontconfig1 libfontconfig1:i386 \
 libfreetype6:i386 libgcc1:i386 libgcrypt11:i386 libglib2.0-0:i386 \
 libgnutls26:i386 libgpg-error0:i386 libgsm1:i386 libgssapi-krb5-2:i386 \
 libgstreamer-plugins-base0.10-0:i386 libgstreamer0.10-0:i386 libice6:i386 \
 libjack-jackd2-0:i386 libjbig0:i386 libjpeg8:i386 libjson0:i386 \
 libk5crypto3:i386 libkeyutils1:i386 libkrb5-3:i386 libkrb5support0:i386 \
 liblcms1:i386 liblzma5:i386 libmng1:i386 libmp3lame0:i386 libogg0:i386 \
 libopenjpeg2:i386 liborc-0.4-0:i386 libp11-kit0:i386 libpcre3:i386 \
 libpng12-0:i386 libpulse0:i386 libqt4-dbus:i386 libqt4-network:i386 \
 libqt4-xml libqt4-xml:i386 libqtcore4 libqtcore4:i386 libqtdbus4 \
 libqtdbus4:i386 libqtgui4:i386 libqtwebkit4:i386 libsamplerate0:i386 \
 libschroedinger-1.0-0:i386 libselinux1:i386 libsm6:i386 libsndfile1:i386 \
 libspeex1:i386 libspeexdsp1:i386 libsqlite3-0:i386 libssl1.0.0:i386 \
 libstdc++6:i386 libtasn1-3:i386 libtheora0:i386 libtiff4:i386 libuuid1:i386 \
 libva1:i386 libvorbis0a:i386 libvorbisenc2:i386 libvpx1:i386 libwrap0:i386 \
 libx11-6:i386 libx11-xcb1:i386 libx264-123:i386 libxau6:i386 libxcb1:i386 \
 libxdmcp6:i386 libxext6:i386 libxi6:i386 libxml2:i386 libxrender1:i386 \
 libxss1:i386 libxt6:i386 libxtst6:i386 libxv1:i386 libxvidcore4:i386 qdbus \
 ttf-dejavu-core uuid-runtime zlib1g:i386
}

install_prereq_centos_6_skypopen()
{
#In addition to the packages required to build and run FreeSWITCH, you will
#need the following:

 # Dependencies for building mod_skypopen:
 yum install libx11-devel

 # Infrastructure needed to run skype client:
 yum install pulseaudio Xvfb xorg-x11-fonts* xz pulseaudio-utils

 # Dependencies of skype client:
 # Enable libraries repo
 yum localinstall http://download.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
 # Install libraries
 yum install qt-x11.i686 qtwebkit.i686 glibc.i686  libgcc.i686 libstdc++.i686 libXv.i686 \
 libX11.i686 libXext.i686 libXScrnSaver.i686 libcanberra-gtk2.i686 \
 gtk2-engines.i686 PackageKit-gtk-module.i686
}

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

install_prereq_rpm()
{
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
  yum install qtwebkit.i686 webkitgtk.i686
  yum install alsa-lib.i686 libXv.i686 libXScrnSaver.i686 gtk2-engines.i686 \
    PackageKit-gtk-module.i686 libcanberra.i686 libcanberra-gtk2.i686
  yum install pulseaudio-libs.i686 alsa-plugins-pulseaudio.i686
  yum install libv4l.i686

  # For 64 bit CentOS, Then, to run Skype, load the 32-bit v4l1compat.so:
  # [user@host]$ LD_PRELOAD=/usr/lib/libv4l/v4l1compat.so /opt/skype/skype

  # 1.4. Adding skype.desktop to Desktops
  #If you want to have skype.desktop to show up on users desktops, 
  # you need to edit the file /usr/share/skype/skype.desktop and search for the line that says:
  #Icon=skype.png
  #and change it too
  #Icon=/usr/share/skype/icons/SkypeBlue_48x48.png
  #then copy the skype.desktop file into the user(s) Desktop with the command:
  #[root@host]# cp -a /usr/share/skype/skype.desktop ~<username>/Desktop
  #[root@host]# chown <username> ~<username>/Desktop/skype.desktop

  #1.5. Running Skype
  #You can run the skype program (as a normal user) from the command line with the command:
  #[user@host]$ skype
  #Also, if you installed the skype.desktop file above, you should be able to
  # double click it from your desktop.
}


enable_pulseaudio_disable_oss_disable_alsa()
{
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
}

enable_freeswitch_skypopen_skype_client_startup()
{
  #    nano /usr/local/freeswitch/skypopen/skype-clients-startup-dir/start_skype_clients.sh
  #    check if you have the following lines
  #    Code:
  cat <<EOF > /usr/local/freeswitch/skypopen/skype-clients-startup-dir/start_skype_clients.sh
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
EOF
}
#    tested on two Asterisk 1.6.2.4 + FreePBX 2.8.1.5 + Freeswitch 1.2.10 PBXes
##10
#pilovis, Sep 26, 2014 

install_skype_client
install_prereq_debian
install_prereq_debian_7_skypopen
install_prereq_ubuntu_14_skypopen
install_prereq_centos_6_skypopen
install_prereq_rpm
enable_pulseaudio_disable_oss_disable_alsa
enable_freeswitch_skypopen_skype_client_startup

