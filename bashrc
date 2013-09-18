# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alrth'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

alias c='clear'

# vim!
export EDITOR=vim 

### Note taking
export NOTES_DIR=~/Dropbox/notes
# Create/edit notes
n() {
	$EDITOR $NOTES_DIR/"$*".md
}

# Edit file given index to last query
nne() {
	$EDITOR $NOTES_DIR/`awk "NR==$1" $NOTES_DIR/files.txt`
}

# View note given name
nv() {
	markdown $NOTES_DIR/$*.md | lynx -stdin
}

# View note given index to last query
nnv() {
	markdown $NOTES_DIR/`awk "NR==$1" $NOTES_DIR/files.txt` | lynx -stdin
}

# Search for a tag, display files
nft() {
	export NOTES_PWD=`pwd`
	cd $NOTES_DIR/
	grep -l "#$*" *.md | tee files.txt | paste - <(head -q -n 1 `cat files.txt`) | nl
	cd $NOTES_PWD
}

# Generate all files, including an index
ng() {
	echo "<html><head><title>Index</title></head><body><ul>" > $NOTES_DIR/index.html
	for f in $NOTES_DIR/*.md
	do
		f2=${f%.*}.html
		markdown $f > $f2
		echo "<li><a href=$f2>`head -1 $f`</a>" >> $NOTES_DIR/index.html	
	done
	echo "</ul></body></html>" >> $NOTES_DIR/index.html
}

nls () {
	tree -CR --noreport $NOTES_DIR -P *.md | awk '{ if ((NR > 1) gsub(/.md/,"")); \
	if (NF==1) print $1; else if (NF==2) print $2; else if (NF==3) printf "  %s\n", $3 }' ;
}
