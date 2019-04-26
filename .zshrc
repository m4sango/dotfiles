# 環境変数
export LANG=ja_JP.UTF-8
fpath=($(brew --prefix)/share/zsh/site-functions $fpath)

## 見た目
# 色を使用出来るようにする
autoload -Uz colors
colors

# Git
# vcs_infoを読み込み
autoload -Uz vcs_info

# vcs_info_msg_0_変数をどのように表示するかフォーマットの指定
## デフォルトのフォーマット
### %s: どのバージョン管理システムを使っているか（git, svnなど）
### %b: ブランチ名
zstyle ':vcs_info:*' formats '(%s)[%b]'
## 特別な状態（mergeでコンフリクトしたときなど）でのフォーマット
### %a: アクション名（merge, rebaseなど）
zstyle ':vcs_info:*' actionformats '(%s)[%b|%a]'

# プロンプトが表示される毎にバージョン管理システムの情報を取得
## precmd: プロンプトが表示される毎に実行される関数
## vcs_info: バージョン管理システムから情報を取得
precmd () { vcs_info }

# 右プロンプトに表示
## prompt_subst: プロンプトを表示する際に変数を展開するオプション
setopt prompt_subst
## vcs_info_msg_0_: バージョン管理システムの情報
## RPROMPT: 右プロンプトに情報を表示するときの環境変数
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'


## ヒストリの設定
HISTFILE=~/.zsh_history
# メモリに保存される履歴の件数
export HISTSIZE=1000
# 履歴ファイルに保存される履歴の件数
export SAVEHIST=100000
# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups
# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks
# historyコマンドは履歴に登録しない
setopt hist_no_store

## プロンプト
PROMPT="%{${fg[green]}%}[%n@%m]%{${reset_color}%} %~
%# "

# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

## 補完
# 補完機能を有効にする
autoload -Uz compinit
compinit
# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

## オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit
# beep を無効にする
setopt no_beep
# Ctrl+Dでzshを終了しない
setopt ignore_eof
# '#' 以降をコメントとして扱う
setopt interactive_comments
# ディレクトリ名だけでcdする
setopt auto_cd
# 同時に起動したzshの間でヒストリを共有する
setopt share_history

## alias
# コマンド
alias ll='ls -alF'
alias zshrc='vim ~/dotfiles/.zshrc'
alias vimrc='vim ~/dotfiles/.vimrc'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias hgrep='history -E 1 | grep $1'
alias atom='atom -a $1'
