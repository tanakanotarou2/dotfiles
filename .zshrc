# fzf  
# `,` で保管を有効に
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh && \
export FZF_COMPLETION_TRIGGER="," # (default:) '**' 


# node
[ -d $HOME/.nodebrew ] && \
export PATH=$HOME/.nodebrew/current/bin:$PATH


# ruby
[ -d $HOME/.rbenv ] && \
export PATH="$HOME/.rbenv/bin:$PATH" && \
eval "$(rbenv init -)"


# python global環境用 venv
[ -f $HOME/.venv/global/bin/activate ] && \
    source ~/.venv/global/bin/activate

# deno
[ -d $HOME/.deno ] && \
export DENO_INSTALL="${HOME}/.deno" && \
export PATH="$DENO_INSTALL/bin:$PATH"


# del command
# https://github.com/andreafrancia/trash-cli
# 削除の代わりにゴミ箱に移動する
if which trash-put &>/dev/null; then
    alias del=trash-put
fi


# alias
alias ll="ls -la"
alias cp="cp -r"

if which nvim &>/dev/null; then
    alias vim="nvim"
fi

# history
# メモリに保存される履歴の件数
export HISTSIZE=1000
# 履歴ファイルに保存される履歴の件数
export SAVEHIST=100000
# 重複を記録しない
setopt hist_ignore_dups
# 開始と終了を記録
setopt share_history

# ls など単純なコマンドを記録しない
# see: http://mollifier.hatenablog.com/entry/20090728/p1
zshaddhistory() {
    local line=${1%%$'\n'}
    local cmd=${line%% *}

    # 以下の条件をすべて満たすものだけをヒストリに追加する
    [[ ${#line} -ge 5
        && ${cmd} != (l|l[sal])
        && ${cmd} != (c|cd)
        && ${cmd} != (m|man)
    ]]
}

