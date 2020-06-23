# According to the Zsh Plugin Standard:
# http://zdharma.org/Zsh-100-Commits-Club/Zsh-Plugin-Standard.html

0=${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}
0=${${(M)0:#/*}:-$PWD/$0}

# Then ${0:h} to get plugin's directory

if [[ ${zsh_loaded_plugins[-1]} != */zsh-fzf && -z ${fpath[(r)${0:h}/functions]} ]] {
    fpath+=( "${0:h}/functions" )
}

# Standard hash for plugins, to not pollute the namespace
typeset -gA Plugins
Plugins[ZSH_FZF_DIR]="${0:h}"

typeset -gA ZSH_FZF

typeset -gAH _ZSH_FZF
_ZSH_FZF[TRUTHY]="true|yes|on|1"

autoload -Uz .fzf-cmd .fzf-redraw-prompt .fzf-append-left-buffer fzf-file \
              fzf-cd fzf-history

zle -N fzf-redraw-prompt .fzf-redraw-prompt

zle -N fzf-file
bindkey '^T' fzf-file

function fzf-file-preview() fzf-file 'preview'
zle -N fzf-file-preview
bindkey '^F' fzf-file-preview

zle -N fzf-cd
bindkey '^G' fzf-cd

zle -N fzf-history
bindkey '^R' fzf-history

