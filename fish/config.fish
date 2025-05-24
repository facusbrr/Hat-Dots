# ~/.config/fish/config.fish
# ===================================================
# Fish Shell Configuration
# Personal shell setup for Linux/WSL + LazyVim dev
# Theme: Kanagawa Dragon | Prompt: Starship
# Tools: zoxide, atuin, fzf, carapace, zellij (pending)
# ===================================================

# ─── INTERACTIVE SESSION ─────────────────────────────
if status is-interactive
    # Instalar Fisher si no está instalado (gestor de plugins)
    if not functions -q fisher
        curl -sL https://git.io/fisher | source
        fisher install jorgebucaran/fisher
    end
end
# ─── ZELLIJ ─────────────────────────────────────────
if not set -q ZELLIJ
   zellij
end
# ─── BREW ENV ────────────────────────────────────────
# Detectar sistema y configurar ruta de Homebrew
if test (uname) = Darwin
    set BREW_BIN /opt/homebrew/bin/brew
else
    set BREW_BIN /home/linuxbrew/.linuxbrew/bin/brew
end

# Agregar entorno de Homebrew al PATH
eval ($BREW_BIN shellenv)

# ─── GLOBAL PATH ─────────────────────────────────────
# Rutas para herramientas comunes
set -x PATH $HOME/.volta/bin \
            $HOME/.bun/bin \
            $HOME/.nix-profile/bin \
            /nix/var/nix/profiles/default/bin \
            /usr/local/bin \
            $HOME/.cargo/bin \
            $HOME/.config \
            $PATH

# ─── INICIALIZAR HERRAMIENTAS ───────────────────────
starship init fish | source      # Prompt moderno
zoxide init fish | source        # Mejor cd
atuin init fish | source         # Historial potente
fzf --fish | source              # Búsqueda fuzzy integrada

# ─── COLOR SCHEME: Kanagawa Dragon ──────────────────

# Base colors
set -l foreground C5C9C5
set -l selection 2A2A37
set -l comment 727169

# Accents
set -l red E82424
set -l orange FF9E64
set -l yellow FFC777
set -l green 98BB6C
set -l purple 9CABCA
set -l cyan 7E9CD8
set -l pink D27E99

# Sintaxis
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $orange
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Autocompletado
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment

# ─── AUTOCOMPLETADO - CARAPACE ──────────────────────
# Inicializa las completions de CLI inteligentes

set -Ux CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense'

# Asegura la carpeta de completions
if not test -d ~/.config/fish/completions
    mkdir -p ~/.config/fish/completions
end

# Generar archivos vacíos la primera vez
if not test -f ~/.config/fish/completions/.initialized
    carapace --list | awk '{print $1}' | xargs -I{} touch ~/.config/fish/completions/{}.fish
    touch ~/.config/fish/completions/.initialized
end

# Cargar Carapace completions
carapace _carapace | source

# ─── ZELLIJ (pendiente de configurar) ───────────────
# Configuración futura para iniciar Zellij automáticamente si se desea
# if not set -q ZELLIJ; zellij attach -c default; end

# ─── LS COLORS / VISUAL ─────────────────────────────
# Mejora visual de listados
set -x LS_COLORS "di=38;5;67:ow=48;5;60:ex=38;5;132:ln=38;5;144:*.tar=38;5;180:*.zip=38;5;180:*.jpg=38;5;175:*.png=38;5;175:*.mp3=38;5;175:*.wav=38;5;175:*.txt=38;5;223:*.sh=38;5;132"

# Desactiva saludo por defecto
set -g fish_greeting ""

# ─── ALIAS ÚTILES ───────────────────────────────────
# Alias para sistemas compatibles
if test (uname) = Darwin
    alias ls='ls --color=auto'
else
    alias ls='gls --color=auto'
end

alias fzfbat='fzf --preview="bat --theme=ansi --color=always {}"'
alias fzfnvim='nvim (fzf --preview="bat --theme=ansi --color=always {}")'

# ─── Auto-Actualizacion de Herramientas ──────────────────────────────────────────
function check-tools
    for tool in starship zoxide atuin fzf carapace
        if not type -q $tool
            echo "$tool no está instalado"
        else
            echo "$tool ✔"
        end
    end
end

# ─── FINAL ──────────────────────────────────────────
clear

