# The Black Lodge Theme for ZSH
# Inspired by Twin Peaks, where things are not what they seem

# Function to reverse text with toggle support
maybe_reverse_text() {
    local input=$1
    # Check if BLACK_LODGE_REVERSE is set to "true"
    if [[ "${BLACK_LODGE_REVERSE:-false}" == "true" ]]; then
        local length=${#input}
        local reversed=""
        for ((i = length; i > 0; i--)); do
            reversed="$reversed${input[i]}"
        done
        echo $reversed
    else
        echo $input
    fi
}

# Toggle function that can be called by the user
toggle_black_lodge() {
    if [[ "${BLACK_LODGE_REVERSE:-false}" == "true" ]]; then
        export BLACK_LODGE_REVERSE=false
        echo "Black Lodge text is now normal"
    else
        export BLACK_LODGE_REVERSE=true
        echo "Black Lodge text is now reversed"
    fi
    # Force prompt refresh
    zle reset-prompt
}

# Add the toggle function to ZSH widgets and bind it to a key
zle -N toggle_black_lodge
bindkey '^B' toggle_black_lodge  # Ctrl+B to toggle

# Color definitions inspired by Twin Peaks
BLACK_LODGE_RED="196"      # The red room
LAURA_BLUE="39"           # Laura's jacket/The neon of the Double R Diner
DARK_WOODS="22"           # The dark woods of Twin Peaks
LOG_LADY_BROWN="130"      # Log Lady's log
COFFEE_BROWN="94"         # Agent Cooper's coffee
OWL_CAVE_GREY="240"      # The mysterious caves
AUDREY_RED="160"         # Audrey's lipstick
PEARL_LAKES_GREEN="29"   # Pearl Lakes

# Set root/user color distinction
if [ $UID -eq 0 ]; then 
    NCOLOR="$BLACK_LODGE_RED"
else 
    NCOLOR="$LAURA_BLUE"
fi

# Custom function to handle the current directory path
get_path() {
    local path=$(basename "$PWD")
    maybe_reverse_text "$path"
}

# Git status indicators
ZSH_THEME_GIT_PROMPT_PREFIX="%{$FG[$LOG_LADY_BROWN]%}[%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$FG[$LOG_LADY_BROWN]%}]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$FG[$BLACK_LODGE_RED]%} ✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$FG[$PEARL_LAKES_GREEN]%} ✓%{$reset_color%}"

# Additional git status
ZSH_THEME_GIT_PROMPT_ADDED="%{$FG[$PEARL_LAKES_GREEN]%}+%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$FG[$AUDREY_RED]%}!%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$FG[$BLACK_LODGE_RED]%}-%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$FG[$LAURA_BLUE]%}>%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$FG[$BLACK_LODGE_RED]%}≠%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$FG[$OWL_CAVE_GREY]%}?%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_STASHED="%{$FG[$COFFEE_BROWN]%}$%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$FG[$BLACK_LODGE_RED]%}↓%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$FG[$LAURA_BLUE]%}↑%{$reset_color%}"

# Function to show git status (always forward)
git_status_info() {
    local ref
    if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
        ref=$(git symbolic-ref HEAD 2> /dev/null) || \
        ref="➦ $(git rev-parse --short HEAD 2> /dev/null)"
        echo -n "${ZSH_THEME_GIT_PROMPT_PREFIX}${ref#refs/heads/}"
        
        # Branch status
        if [[ -n $(git status -s 2> /dev/null) ]]; then
            echo -n "$ZSH_THEME_GIT_PROMPT_DIRTY"
        else
            echo -n "$ZSH_THEME_GIT_PROMPT_CLEAN"
        fi
        
        # Added files
        if $(git status -s 2> /dev/null | grep '^A ' &> /dev/null); then
            echo -n "$ZSH_THEME_GIT_PROMPT_ADDED"
        fi
        
        # Modified files
        if $(git status -s 2> /dev/null | grep '^ M ' &> /dev/null); then
            echo -n "$ZSH_THEME_GIT_PROMPT_MODIFIED"
        fi
        
        # Deleted files
        if $(git status -s 2> /dev/null | grep '^ D ' &> /dev/null); then
            echo -n "$ZSH_THEME_GIT_PROMPT_DELETED"
        fi
        
        # Renamed files
        if $(git status -s 2> /dev/null | grep '^R ' &> /dev/null); then
            echo -n "$ZSH_THEME_GIT_PROMPT_RENAMED"
        fi
        
        # Unmerged files
        if $(git status -s 2> /dev/null | grep '^UU ' &> /dev/null); then
            echo -n "$ZSH_THEME_GIT_PROMPT_UNMERGED"
        fi
        
        # Untracked files
        if $(git status -s 2> /dev/null | grep '^?? ' &> /dev/null); then
            echo -n "$ZSH_THEME_GIT_PROMPT_UNTRACKED"
        fi
        
        # Check for stashed files
        if $(git rev-parse --verify refs/stash >/dev/null 2>&1); then
            echo -n "$ZSH_THEME_GIT_PROMPT_STASHED"
        fi
        
        # Check if ahead/behind remote
        local remote="$(git rev-parse --verify ${hook_com[branch]}@{upstream} --symbolic-full-name 2>/dev/null)"
        if [[ -n "${remote}" ]]; then
            local -a gitstatus
            local commits="$(git rev-list --count --left-right ${hook_com[branch]}...${remote} 2>/dev/null)"
            if [[ $commits =~ "^[0-9]+[[:space:]]+[0-9]+$" ]]; then
                local ahead=$(echo $commits | awk '{print $1}')
                local behind=$(echo $commits | awk '{print $2}')
                if [[ $ahead -gt 0 ]]; then
                    echo -n "$ZSH_THEME_GIT_PROMPT_AHEAD"
                fi
                if [[ $behind -gt 0 ]]; then
                    echo -n "$ZSH_THEME_GIT_PROMPT_BEHIND"
                fi
            fi
        fi
        
        echo -n "$ZSH_THEME_GIT_PROMPT_SUFFIX"
    fi
}

# Main prompt with toggleable reversed text for user/path
PROMPT='%{$FG[$NCOLOR]%}%B$(maybe_reverse_text "%n")%b%{$reset_color%}%{$FG[$LOG_LADY_BROWN]%}:%{$reset_color%}%{$FG[$COFFEE_BROWN]%}%B$(get_path)/%b%{$reset_color%} $(git_status_info)%(!.%{$FG[$BLACK_LODGE_RED]%}#.%{$FG[$LAURA_BLUE]%}$)%{$reset_color%} '
RPROMPT='%{$FG[$OWL_CAVE_GREY]%}[$(maybe_reverse_text "%*")]%{$reset_color%}'

# Directory and file colors inspired by Twin Peaks locations and objects
export LSCOLORS="GxfxcxdxbxDxDxabagacad"
export LS_COLORS="di=38;5;${BLACK_LODGE_RED}:ln=38;5;${LAURA_BLUE}:so=38;5;${LOG_LADY_BROWN}:pi=38;5;${COFFEE_BROWN}:ex=38;5;${BLACK_LODGE_RED}:bd=38;5;${OWL_CAVE_GREY}:cd=38;5;${OWL_CAVE_GREY}:su=38;5;${BLACK_LODGE_RED}:sg=38;5;${BLACK_LODGE_RED}:tw=38;5;${DARK_WOODS}:ow=38;5;${DARK_WOODS}"

# Add helpful aliases for Black Lodge theme
alias reverse_on="export BLACK_LODGE_REVERSE=true && zle reset-prompt"
alias reverse_off="export BLACK_LODGE_REVERSE=false && zle reset-prompt"