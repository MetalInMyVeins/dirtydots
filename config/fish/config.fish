set fish_greeting

if status is-interactive
  # Commands to run in interactive sessions can go here
end

fish_add_path ~/.bin
#fish_add_path ~/.local/bin
#fish_add_path ~/devel/tempath

alias neofetch "neofetch --config ~/.config/neofetch/config.conf"

# Android development from command line
#fish_add_path ~/Android/Sdk/cmdline-tools/latest/bin/
#fish_add_path ~/Android/Sdk/platform-tools/

#set -x CPATH ~/.include ~/.local/include
#set -x CC /usr/bin/gcc
#set -x CXX /usr/bin/g++
#set -x WINCC /usr/bin/x86_64-w64-mingw32-gcc
#set -x WINCXX /usr/bin/x86_64-w64-mingw32-g++
#set -x WINSTRIP /usr/bin/x86_64-w64-mingw32-strip
set -x GTK_THEME Adwaita-dark
set -x EDITOR nvim
set -x QT_QPA_PLATFORMTHEME qt6ct
set -x QT_QUICK_CONTROLS_STYLE org.kde.desktop
# set -x PYTHONSTARTUP /home/metal888/.pystartup
#set -x QT_STYLE_OVERRIDE kvantum
#set -x XDG_MENU_PREFIX arch- kbuildsycoca6
#set -x DOCKER_HOST unix://$XDG_RUNTIME_DIR/docker.sock

set -x PYENV_ROOT $HOME/.pyenv
set -x fish_user_paths $PYENV_ROOT/bin $fish_user_paths


# Disable video acceleration

#set -x LD_LIBRARY_PATH ~/.local/lib

#alias feh='feh --fullscreen'
#alias R='R --quiet'
#alias qemu-aarch64='qemu-aarch64 -L /usr/aarch64-linux-gnu'
#alias aarch64-linux-gnu-objdump='aarch64-linux-gnu-objdump --disassembler-color=on'

#alias dart='dart --enable-asserts --verbosity=all --enable-analytics'

#env LIBVA_DRIVER_NAME=null vlc
#env LIBVA_DRIVER_NAME=null brave

# set -x LS_COLORS 'rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=00:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.avif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:*~=00;90:*#=00;90:*.bak=00;90:*.crdownload=00;90:*.dpkg-dist=00;90:*.dpkg-new=00;90:*.dpkg-old=00;90:*.dpkg-tmp=00;90:*.old=00;90:*.orig=00;90:*.part=00;90:*.rej=00;90:*.rpmnew=00;90:*.rpmorig=00;90:*.rpmsave=00;90:*.swp=00;90:*.tmp=00;90:*.ucf-dist=00;90:*.ucf-new=00;90:*.ucf-old=00;90:'

# ex=01;38;2;00;130;00:
# this controls the executable color in the fish shell which is HARDCODED to soft green. so executable color wouldn't follow terminal green
set -x LS_COLORS 'rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=00:tw=30;42:ow=34;42:st=37;44:ex=01;38;2;00;130;00:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.avif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:*~=00;90:*#=00;90:*.bak=00;90:*.crdownload=00;90:*.dpkg-dist=00;90:*.dpkg-new=00;90:*.dpkg-old=00;90:*.dpkg-tmp=00;90:*.old=00;90:*.orig=00;90:*.part=00;90:*.rej=00;90:*.rpmnew=00;90:*.rpmorig=00;90:*.rpmsave=00;90:*.swp=00;90:*.tmp=00;90:*.ucf-dist=00;90:*.ucf-new=00;90:*.ucf-old=00;90:'

function ls
  command ls --color=auto $argv
end

# Function to run after each command
function after_command --on-event fish_postexec
    set last_status $status
    #set_color -o 3584E4
    set_color -o af5f00

    if test $last_status -eq 0
      #nothing
    else if test $last_status -eq 1
      echo "Exit code: "$last_status" (general error)"
    else if test $last_status -eq 2
      echo "Exit code: "$last_status" (incorrect usage)"
    else if test $last_status -eq 126
      echo "Exit code: "$last_status" (permission denied)"
    else if test $last_status -eq 127
      echo "Exit code: "$last_status" (command not found)"
    else if test $last_status -eq 128
      echo "Exit code: "$last_status" (invalid exit argument)"
    else if test $last_status -eq 130
      echo "Exit code: "$last_status" (process interrupted)"
    else if test $last_status -eq 137
      echo "Exit code: "$last_status" (process killed)"
    else if test $last_status -eq 139
      echo "Exit code: "$last_status" (segmentation fault)"
    else
      echo "Exit code: "$last_status
    end
end

set -x DEBUGINFOD_URLS "https://debuginfod.archlinux.org"
#set -x DEBUGINFOD_URLS "/dev/null"

# disable cursor blinking
printf '\e[?12l'

pyenv init - fish | source

direnv hook fish | source
set -g direnv_fish_mode disable_arrow


