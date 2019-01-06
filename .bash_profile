export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -lpo'
alias gits='git status && git branch'
alias gita='git add .'
alias giti='git rm -r --cached . && git add . && git commit -m "Updated gitignore" && git push'
export PATH=${PATH}:/usr/local/bin
export PATH=${PATH}:/usr/local/sbin
export PATH=${PATH}:/usr/local/Cellar/mysql/8.0.13/bin
export PATH=${PATH}:/Developer/android-sdk/platform-tools
export PATH=${PATH}:/Developer/android-sdk/emulator
export PATH=${PATH}:/Developer/android-sdk/tools
export PATH=${PATH}:/Developer/Flutter/bin
export PATH=${PATH}:∼/.composer/vendor/bin
source ~/.git-completion.bash
