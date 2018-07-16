source /etc/profile

aurin(){
    [[ ! -d aur_packages ]] && mkdir aur_packages
    pushd aur_packages
    for PKG in "$@" ; do
        curl -o ${PKG}.tar.gz https://aur.archlinux.org/cgit/aur.git/snapshot/${PKG}.tar.gz
        tar zxvf ${PKG}.tar.gz
        rm ${PKG}.tar.gz
        pushd ${PKG}
        makepkg -csi --noconfirm
        popd
    done
    popd
    rm -rf aur_packages # Uncomment if you want to clean up after install
}

alias play='DRI_PRIME=1 mplayer'
alias st='/home/partha/Programs/sublime_text_3/sublime_text'
alias pycharm='/home/partha/Programs/pycharm-community-2018.1.4/bin/pycharm.sh'
alias blender='/home/partha/Programs/blender-2.79b-linux-glibc219-x86_64/blender'

PS1="[\u@\h] \W\\$ "

#export EDITOR=/home/partha/Programs/sublime_text_3/sublime_text
#export VISUAL=/home/partha/Programs/sublime_text_3/sublime_text
export PATH=/usr/local/texlive/2018/bin/x86_64-linux:$PATH
export INFOPATH=$INFOPATH:/usr/local/texlive/2018/texmf-dist/doc/info
export MANPATH=$MANPATH:/usr/local/texlive/2018/texmf-dist/doc/man
