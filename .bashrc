source /etc/profile

# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
(cat ~/.cache/wal/sequences &)

# Alternative (blocks terminal for 0-3ms)
cat ~/.cache/wal/sequences

# To add support for TTYs this line can be optionally added.
source ~/.cache/wal/colors-tty.sh

walc(){
  wal -i "$@"
  cp -f "$@" ${HOME}/.wallpaper
}

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

mmd(){
  echo --- >> "$1"
  echo title: $2 >> "$1"
  echo geometry: "left=1cm,right=1cm,top=1cm,bottom=1cm" >> "$1"
  echo fontsize: 11pt >> "$1"
  echo papersize: a4 >> "$1"
  echo header-includes: >> "$1"
  echo "  \usepackage{listings,xcolor,graphicx,wrapfig}
  \usepackage{float}\let\origfigure\figure\let\endorigfigure\endfigure\renewenvironment{figure}[1][2] {\expandafter\origfigure\expandafter[H]} {\endorigfigure}
  \lstset{ basicstyle=\ttfamily, columns=fullflexible}" >> "$1"
#  echo abstract: >> "$1"
  echo --- >> "$1"
  echo "\input{commands}" >> "$1"
  echo "\everymath{\displaystyle}" >> "$1"
}
mdcmd(){
  cp /home/${USER}/Templates/Markdown/commands.tex .
}
mdhtml(){
  pandoc "$1.md" -f markdown -t html -s --mathjax -o "$1.html" && mkdir -p htmls &&mv "$1.html" ./htmls/
}
mdpdf(){
  pandoc -f markdown -t latex -o "$1.pdf" "$1.md" --pdf-engine=xelatex && mkdir -p pdfs && mv "$1.pdf" ./pdfs/
}
mdhall(){
  cat *.md | tee $1.md | mdhtml $1 && rm $1.md && mkdir -p htmls && mv "$1.html" ./htmls/
}
mdpall(){
  cat *.md | tee $1.md | mdpdf $1 && rm $1.md && mkdir -p pdfs && mv "$1.pdf" ./pdfs/
}
ss(){
  mv -i /home/partha/Pictures/screenshots/*.png ./$1.png
}
dss(){
  rm /home/partha/Pictures/screenshots/*.png
}

# make multiple shell share same history file
export HISTSIZE=10000           # bash history will save N commands
export HISTFILESIZE=${HISTSIZE} # bash will remember N commands
export HISTCONTROL=ignoreboth   # ingore duplicates and spaces
export HISTIGNORE='&:ls:ll:la:cd:exit:clear:history:c'

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias la='ls -halF'

alias play='DRI_PRIME=1 mplayer'
alias mp='play *.mp4 -sub *.srt'
alias r='ranger'
alias pycharm='/home/partha/Programs/pycharm-community-2018.1.4/bin/pycharm.sh'
alias blender='/home/partha/Programs/blender-2.79b-linux-glibc219-x86_64/blender'
alias memo='python /home/partha/Programs/SimpleMemo/SimpleMemo.py'
alias editmemo='vim /home/partha/Programs/SimpleMemo/data.json'

# Setting Bash prompt. Capitalizes username and host if root user (my root user uses this same config file).
if [ "$EUID" -ne 0 ]
	then export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
	else export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]ROOT\[$(tput setaf 2)\]@\[$(tput setaf 4)\]$(hostname | awk '{print toupper($0)}') \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
fi

#export EDITOR=/home/partha/Programs/sublime_text_3/sublime_text
#export VISUAL=/home/partha/Programs/sublime_text_3/sublime_text
export PATH=/usr/local/texlive/2018/bin/x86_64-linux:$(ruby -e 'print Gem.user_dir')/bin:$PATH
export INFOPATH=$INFOPATH:/usr/local/texlive/2018/texmf-dist/doc/info
export MANPATH=$MANPATH:/usr/local/texlive/2018/texmf-dist/doc/man
