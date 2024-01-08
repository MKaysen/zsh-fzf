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

(( ${+commands[fzf]} )) && () {

  local initfile=${XDG_CONFIG_HOME:-$HOME/.config/fzf/fzf.zsh}
  if [[ -e $initfile ]]; then
    source $initfile
  fi

} ${Plugins[ZSH_FZF_DIR]}

