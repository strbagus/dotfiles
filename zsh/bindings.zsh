# =========================================================
# Keybindings
# =========================================================

# Cursor shape per vi mode
ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BEAM
ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
ZVM_VISUAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK

# Disable command mode line highlight
ZVM_VI_HIGHLIGHT_BACKGROUND=none
ZVM_VI_HIGHLIGHT_FOREGROUND=none
ZVM_VI_HIGHLIGHT_EXTRASTYLE=none

# zsh-vi-mode resets all bindings on init, so custom bindings
# must be registered via this hook to survive.
zvm_after_init() {
  # Ctrl+Right -> move forward one word (^[[1;5C is the terminal escape code)
  bindkey '^[[1;5C' forward-word

  # Ctrl+Left -> move backward one word (^[[1;5D is the terminal escape code)
  bindkey '^[[1;5D' backward-word

  # Ctrl+F -> fzf file picker (no hidden files)
  bindkey '^F' _fzf_file_no_hidden

  # Ctrl+\ -> toggle autosuggestions (useful for screen recordings)
  # bindkey '^\' autosuggest-toggle

  # Up/Down -> history search by substring (^[[A/^[[B are up/down arrow escape codes)
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
	# Ensure the terminfo module is loaded

	# Escape to normal mode with JK in 200ms
  KEYTIMEOUT=20
  zvm_bindkey viins 'jk' zvm_exit_insert_mode
	zmodload zsh/terminfo

	# Bind Up Arrow
	if [[ -n "$terminfo[kcuu1]" ]]; then
	  bindkey "$terminfo[kcuu1]" history-substring-search-up
	else
	  bindkey '^[[A' history-substring-search-up
	fi
	
	# Bind Down Arrow
	if [[ -n "$terminfo[kcud1]" ]]; then
	  bindkey "$terminfo[kcud1]" history-substring-search-down
	else
	  bindkey '^[[B' history-substring-search-down
	fi
}
