
# History File
HISTFILE=~/.config/zsh/.histfile
HISTSIZE=10000
SAVEHIST=50000000
bindkey -e
setopt hist_ignore_space
setopt hist_ignore_all_dups

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

autoload compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

alias x="sudo powertop --auto-tune; startx"
alias bt="~/Dev/scripts/bluetooth.sh"
alias la="exa --long --icons --header --git --no-user --group-directories-first --octal-permissions"
alias abrave="brave --use-gl=desktop --enable-features=VaapiVideoDecoder --disable-features=UseOzonePlatform >/dev/null 2>&1 & disown"
alias resolve="prime-run /opt/resolve/bin/resolve >/dev/null 2>&1 & disown"
alias sprunge="curl -fsLF 'sprunge=<-' http://sprunge.us"
alias docker="sudo docker"
alias docker-compose="sudo docker-compose"
alias leet="vivaldi-stable --no-sandbox --disable-background-networking --disable-background-timer-throttling --disable-backing-store-limit --disable-breakpad --app='https://leetcode.com/problemset/all/' >/dev/null 2>&1 & disown && cd ~/Dev/leetcode/ && code ."

function ccpp(){
	g++ -o $1 $1.cpp && ./$1
}

function mk() {
	mkdir -p $@ && cd ${@:$#}
}

function packages(){
	pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'
}

function fvim(){
	loc=$(fzf --exact --preview="bat --color=always {}" --prompt="$EDITOR > " --bind K:preview-page-up,J:preview-page-down) && ${EDITOR:-vim} $loc
}

function spr(){
	cat "$@" | command curl -fsLF 'sprunge=<-' http://sprunge.us | tr -d "\n" | xclip -in -sel clip
}

function syay() {
	SELECTED_PKGS="$(yay -Slq | fzf --header='Install packages' -m --height 100% --preview 'yay -Si {1}')"
	if [ -n "$SELECTED_PKGS" ]; then
		yay -S $(echo $SELECTED_PKGS)
	fi
}

function ryay() {
	SELECTED_PKGS="$(yay -Qsq | fzf --header='Remove packages' -m --height 100% --preview 'yay -Si {1}')"
	if [ -n "$SELECTED_PKGS" ]; then
		yay -Rns $(echo $SELECTED_PKGS)
	fi
}

function fe() {
	local files
	IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0 --preview 'bat --color=always --style=header,grid --line-range :300  {} '))
	[[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh
source /usr/share/zsh/plugins/zsh-system-clipboard/zsh-system-clipboard.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/Scripts:$PATH"
#source /usr/share/nvm/init-nvm.sh


bindkey "^K"      kill-whole-line                      # ctrl-k
bindkey "^[[F"    end-of-line                          # end
bindkey "^[[H"    beginning-of-line                    # home
bindkey "^[[3~"   delete-char		                 # delete
bindkey '^[[A'	history-substring-search-up
bindkey '^[[B'	history-substring-search-down

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"
