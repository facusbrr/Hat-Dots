# 🧠 Dotfiles - Configuración Personal de Terminal y Neovim

Este repositorio contiene mis dotfiles personales para un entorno de desarrollo moderno y altamente personalizable en Linux (especialmente en WSL o distros basadas en Ubuntu).

Incluye configuraciones para:

* [Fish Shell](https://fishshell.com/)
* [Zellij](https://zellij.dev/)
* [Neovim](https://neovim.io/) (con LazyVim)
* [Atuin](https://atuin.sh/)
* [Starship Prompt](https://starship.rs/)

---

## 📁 Estructura del Repositorio

```
.
├── atuin/               # Configuración personalizada de Atuin
├── fish/                # Configuración del shell Fish (funciones, prompts, bindings)
├── nvim/                # Configuración de Neovim con LazyVim y plugins
├── zellij/              # Layouts y configuración de Zellij
├── starship.toml        # Prompt universal y minimalista
```

---

## 🚀 Instalación Rápida

```bash
# Clonar el repo
git clone https://github.com/<tu-usuario>/dotfiles ~/.dotfiles

# Crear symlinks (ajustar según tus rutas y preferencias)
ln -s ~/.dotfiles/fish ~/.config/fish
ln -s ~/.dotfiles/nvim ~/.config/nvim
ln -s ~/.dotfiles/zellij ~/.config/zellij
ln -s ~/.dotfiles/atuin ~/.config/atuin
ln -s ~/.dotfiles/starship.toml ~/.config/starship.toml
```

---

## ⚙️ Requisitos

Asegurate de tener instalados los siguientes programas:

| Programa    | Instalar con (Ubuntu/WSL)                                                          |      |
| ----------- | ---------------------------------------------------------------------------------- | ---- |
| Fish Shell  | `sudo apt install fish`                                                            |      |
| Zellij      | `cargo install --locked zellij` o `brew install zellij`                            |      |
| Neovim 0.9+ | [Instrucciones oficiales](https://github.com/neovim/neovim/wiki/Installing-Neovim) |      |
| Atuin       | `bash <(curl https://raw.githubusercontent.com/ellie/atuin/main/install.sh)`       |      |
| Starship    | \`curl -sS [https://starship.rs/install.sh](https://starship.rs/install.sh)        | sh\` |
| Git         | `sudo apt install git`                                                             |      |

Adicionalmente:

* Configura `fish` como tu shell por defecto: `chsh -s $(which fish)`
* Usa una terminal que soporte Nerd Fonts y temas como Kanagawa (recomendado: WezTerm, Alacritty, Kitty).

---

## 🧩 LazyVim + Neovim

La configuración de Neovim está basada en [LazyVim](https://www.lazyvim.org/), e incluye:

* Gestor de plugins ultra rápido (`lazy.nvim`)
* Autocompletado con `nvim-cmp`
* LSPs preconfigurados
* Formateo, linting, snippets
* Atajos productivos con `which-key.nvim`
* Temas visuales como **Kanagawa**

**Para instalar LazyVim:**

```bash
git clone https://github.com/LazyVim/starter ~/.config/nvim
```

Luego reemplazá el contenido con `~/.dotfiles/nvim` si lo usás desde este repo.

---

## 🐟 Fish Shell + Starship + Atuin

El entorno del shell se apoya en:

* **Fish** para scripting moderno y auto-sugerencias
* **Starship** para un prompt informativo y minimalista
* **Atuin** para historial enriquecido y compartido entre sesiones

Incluye:

* Alias comunes (`ll`, `gs`, `nvim .`, etc.)
* Integración con `zoxide`, `fzf`, `bat`, `exa`
* Configuración de Kanagawa como esquema de colores en todo el entorno

---

## 🧱 Zellij

Multiplexor de terminal moderno que reemplaza a `tmux`. La configuración incluye:

* Layouts personalizados
* Integración con `lazygit`, `htop`, `nvim`, etc.
* Keybindings amigables

---

## 🧪 Extras (opcional)

* `lazygit` (para gestionar Git desde TUI)
* `ripgrep` y `fd` (para búsquedas rápidas en Neovim y FZF)
* `zoxide` (para navegar entre carpetas rápidamente)
* `bat` y `exa` (reemplazos modernos de `cat` y `ls`)

---

## 🤝 Contribuciones

Si tenés sugerencias, mejoras o encontraste un bug, sentite libre de abrir un PR o issue. Este repo está pensado para evolucionar y ser compartido.

---

## 🧾 Licencia

MIT License. Usá, modificá y compartí libremente.

---

> Hecho con ❤️ por Facundo

