# 🚀 Windows Development Environment Setup

Este README proporciona una guía completa para configurar un entorno de desarrollo en Windows equivalente a mi configuración de Linux en [Hat-Dots](https://github.com/facusbrr/Hat-Dots), utilizando Neovim, PowerShell mejorado y herramientas complementarias.

**Última actualización:** 2025-05-26

## 📋 Tabla de Contenidos

- [Requisitos previos](#requisitos-previos)
- [Instalación de herramientas base con Scoop](#instalación-de-herramientas-base-con-scoop)
- [Configuración de PowerShell](#configuración-de-powershell)
- [Configuración de Neovim](#configuración-de-neovim)
- [Configuración de Starship](#configuración-de-starship)
- [Terminal Windows y fuentes](#terminal-windows-y-fuentes)
- [Herramientas adicionales recomendadas](#herramientas-adicionales-recomendadas)
- [Resolución de problemas](#resolución-de-problemas)

## 🔧 Requisitos previos

- Windows 10/11 (64-bit)
- Permisos de administrador (para algunas instalaciones)
- Conexión a Internet

## 🛠️ Instalación de herramientas base con Scoop

### 1. Instalar Scoop (Gestor de paquetes)

Abre PowerShell como administrador y ejecuta:

```powershell
# Establecer política de ejecución (sólo una vez)
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

# Instalar Scoop
irm get.scoop.sh | iex
```

### 2. Agregar buckets necesarios

```powershell
scoop bucket add main
scoop bucket add extras
scoop bucket add nerd-fonts
scoop bucket add versions
```

### 3. Instalar herramientas esenciales

```powershell
# Instalar PowerShell 7 (recomendado sobre PowerShell 5.1)
scoop install pwsh

# Herramientas de desarrollo
scoop install git
scoop install neovim
scoop install ripgrep
scoop install fd
scoop install fzf
scoop install lazygit

# Terminal y presentación
scoop install windows-terminal
scoop install JetBrainsMono-NF
scoop install starship
```

## ⚙️ Configuración de PowerShell

### 1. Crear/editar el perfil de PowerShell

Abre PowerShell 7 y ejecuta:

```powershell
# Crear perfil si no existe
if (!(Test-Path -Path $PROFILE)) {
    New-Item -ItemType File -Path $PROFILE -Force
}

# Abrir el perfil para editar
notepad $PROFILE
```

### 2. Agregar la siguiente configuración optimizada

Copia y pega este contenido en tu archivo de perfil:

```powershell
# === Configuración de PSReadLine ===
# Habilitar IntelliSense predictivo basado en historial
Set-PSReadLineOption -PredictionSource History
# Vista de lista para las predicciones
Set-PSReadLineOption -PredictionViewStyle ListView
# Colorear la predicción para mejor visibilidad
Set-PSReadLineOption -Colors @{ InlinePrediction = "#808080" }

# === Navegación mejorada en el historial ===
# Búsqueda en historial con flechas
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
# Ctrl+R para búsqueda avanzada en historial
Set-PSReadLineKeyHandler -Key Ctrl+r -Function ReverseSearchHistory

# === Mejoras de rendimiento ===
# Reducir el tamaño máximo del historial para mejor rendimiento
Set-PSReadLineOption -MaximumHistoryCount 2000
# Habilitar la búsqueda de historial sensible a la posición del cursor
Set-PSReadLineOption -HistorySearchCursorMovesToEnd

# === Atajos de teclado productivos ===
# Ctrl+Space para aceptar sugerencia
Set-PSReadLineKeyHandler -Key Ctrl+Spacebar -Function AcceptSuggestion
# Ctrl+E para ir al final de la línea
Set-PSReadLineKeyHandler -Key Ctrl+e -Function EndOfLine
# Ctrl+A para ir al inicio de la línea
Set-PSReadLineKeyHandler -Key Ctrl+a -Function BeginningOfLine
# Alt+F para avanzar una palabra
Set-PSReadLineKeyHandler -Key Alt+f -Function ForwardWord
# Alt+B para retroceder una palabra
Set-PSReadLineKeyHandler -Key Alt+b -Function BackwardWord

# === Integración con Starship ===
Invoke-Expression (&starship init powershell)

# === Alias útiles para desarrollo ===
Set-Alias -Name vim -Value nvim
Set-Alias -Name ll -Value ls
Set-Alias -Name g -Value git
function gs { git status }
function nv { nvim . }

# === Mejora de rendimiento en la carga ===
$env:POWERSHELL_UPDATECHECK = "Off"  # Desactivar verificación de actualizaciones
```

### 3. Instalar módulos adicionales para PowerShell

```powershell
# Instalar módulo de íconos para terminal
Install-Module -Name Terminal-Icons -Repository PSGallery -Force
# Agregar al perfil (añadir esta línea al archivo $PROFILE)
Import-Module Terminal-Icons

# Instalar módulo z para navegación rápida (similar a zoxide)
Install-Module -Name z -Repository PSGallery -Force
```

## 🔮 Configuración de Neovim

### 1. Configurar LazyVim

```powershell
# Crear directorio de configuración de Neovim
mkdir -p $env:LOCALAPPDATA\nvim

# Clonar LazyVim starter
git clone https://github.com/LazyVim/starter $env:LOCALAPPDATA\nvim

# Opcional: respaldar la configuración existente si ya tienes Neovim configurado
# Rename-Item -Path "$env:LOCALAPPDATA\nvim" -NewName "nvim.bak"
```

### 2. Configurar el portapapeles de Windows

Edita el archivo `$env:LOCALAPPDATA\nvim\lua\config\lazy.lua`:

```powershell
notepad $env:LOCALAPPDATA\nvim\lua\config\lazy.lua
```

Agrega este código justo antes de `require("lazy").setup({`:

```lua
-- Configuración del portapapeles para Windows nativo
if vim.fn.has("win32") == 1 then
  vim.g.clipboard = {
    copy = {
      ["+"] = "clip.exe",
      ["*"] = "clip.exe",
    },
    paste = {
      ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
end
```

### 3. Configurar plugins de LazyVim

Modifica el archivo `$env:LOCALAPPDATA\nvim\lua\config\lazy.lua` para que contenga los mismos plugins que usas en Linux:

```lua
require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- TypeScript/JavaScript
    { import = "lazyvim.plugins.extras.lang.typescript" },

    -- Markdown avanzado y preview
    { import = "lazyvim.plugins.extras.lang.markdown" },

    -- Biome y Prettier: Formateadores
    { import = "lazyvim.plugins.extras.formatting.prettier" },
    { import = "lazyvim.plugins.extras.formatting.biome" },

    -- Mini-files: mini explorador de archivos (liviano y útil)
    { import = "lazyvim.plugins.extras.editor.mini-files" },

    -- Surround: edición rápida de paréntesis, comillas, etc.
    { import = "lazyvim.plugins.extras.coding.mini-surround" },

    -- Snacks extras (opcional - si estaban en tu configuración Linux)
    { import = "lazyvim.plugins.extras.editor.snacks_picker" },
    { import = "lazyvim.plugins.extras.editor.snacks_explorer" },

    -- Tus propios plugins
    { import = "plugins" },
  },
  defaults = { lazy = false, version = false },
  install = { colorscheme = { "kanagawa", "tokyonight" } },
  checker = { enabled = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin",
      },
    },
  },
})
```

## ✨ Configuración de Starship

### 1. Crear directorio y archivo de configuración

```powershell
# Crear directorio de configuración
mkdir -p ~/.config

# Crear archivo de configuración de Starship
New-Item -Path ~/.config/starship.toml -ItemType File -Force
```

### 2. Configurar Starship

Edita el archivo `~/.config/starship.toml`:

```powershell
notepad ~/.config/starship.toml
```

Agrega una configuración mínima (o copia la de tu repositorio Hat-Dots):

```toml
# Configuración base de Starship

[character]
success_symbol = "[➜](bold green)"
error_symbol = "[✗](bold red)"

[directory]
truncation_length = 3
style = "bold blue"

[git_branch]
symbol = "🌿 "
style = "bold purple"

[package]
disabled = false

[nodejs]
symbol = "⬢ "

[rust]
symbol = "🦀 "

[python]
symbol = "🐍 "
```

## 🖥️ Terminal Windows y fuentes

### 1. Configurar Windows Terminal

Windows Terminal se instaló con Scoop, pero necesita configuración adicional:

1. Abre Windows Terminal
2. Presiona `Ctrl+,` para abrir la configuración
3. Establece PowerShell 7 como shell predeterminada
4. Configura la fuente como "JetBrainsMono NF" (o cualquier otra Nerd Font)

### 2. Configuración de colores (opcional)

Puedes usar un tema como Kanagawa (para igualar tu tema de Neovim):

1. En la configuración de Windows Terminal, ve a la sección "Temas de color"
2. Haz clic en "Agregar nuevo"
3. Pega esta configuración de colores Kanagawa:

```json
{
  "name": "Kanagawa",
  "background": "#1F1F28",
  "foreground": "#DCD7BA",
  "cursorColor": "#C8C093",
  "selectionBackground": "#2D4F67",
  "black": "#090618",
  "blue": "#7E9CD8",
  "cyan": "#6A9589",
  "green": "#76946A",
  "purple": "#957FB8",
  "red": "#C34043",
  "white": "#C8C093",
  "yellow": "#DCA561",
  "brightBlack": "#727169",
  "brightBlue": "#7FB4CA",
  "brightCyan": "#7AA89F",
  "brightGreen": "#98BB6C",
  "brightPurple": "#938AA9",
  "brightRed": "#E82424",
  "brightWhite": "#DCD7BA",
  "brightYellow": "#FF9E3B"
}
```

## 🛠️ Herramientas adicionales recomendadas

### 1. Instalar Atuin (historial enriquecido)

Atuin no está disponible en Scoop, pero puedes instalarlo directamente:

1. Descarga el último instalador .msi desde: <https://github.com/atuinsh/atuin/releases>
2. Ejecuta el instalador
3. Agrega a tu perfil de PowerShell:

   ```powershell
   Invoke-Expression (atuin init powershell)
   ```

### 2. Otras herramientas útiles

```powershell
# Herramientas adicionales vía Scoop
scoop install bat     # Alternativa mejorada a cat
scoop install delta   # Visualizador de diff mejorado para git
scoop install glow    # Visualizador de markdown en terminal
```

## 🔍 Resolución de problemas

### Problemas con Neovim

- **Error de clipboard**: Asegúrate de que la configuración del portapapeles en `lazy.lua` esté correcta
- **Problemas con plugins**: Ejecuta `:checkhealth` dentro de Neovim para diagnosticar
- **Rendimiento lento**: Asegúrate de tener ripgrep y fd instalados para búsquedas rápidas

### Problemas con PowerShell

- **Perfil no se carga**: Verifica la política de ejecución con `Get-ExecutionPolicy`
- **Starship no funciona**: Asegúrate de que está instalado y la línea de inicialización en el perfil es correcta
- **Problemas con módulos**: Ejecuta `Import-Module <nombre>` manualmente para ver errores

### Problemas con fuentes

- **Íconos no se muestran**: Asegúrate de que JetBrainsMono NF está instalada y configurada en Windows Terminal
- **Caracteres extraños**: Reinicia Windows Terminal después de instalar las fuentes

---

## 📝 Notas finales

- Esta configuración emula la mayoría de las funcionalidades de tu entorno Linux en Hat-Dots
- PowerShell con las mejoras propuestas ofrece muchas de las capacidades de Fish Shell
- Windows Terminal con paneles puede sustituir a Zellij en muchos casos
- Starship proporciona un prompt consistente entre ambos entornos

---

Creado por [facusbrr](https://github.com/facusbrr) | 2025-05-26
