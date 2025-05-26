# Script automatizado para configurar entorno Windows desde Hat-Dots

Write-Host "🚀 Iniciando setup automatizado para entorno Windows..."

# 0. Instalar Scoop si falta
if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Host "⚠️  Scoop no está instalado. Instalando Scoop..."
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    irm get.scoop.sh | iex
}

# 1. Agregar buckets de Scoop recomendados
scoop bucket add main
scoop bucket add extras
scoop bucket add versions

# 2. Instalar apps recomendadas
$apps = @("neovim", "git", "ripgrep", "fd", "fzf", "lazygit", "windows-terminal", "starship")
foreach ($app in $apps) {
    if (-not (Get-Command $app -ErrorAction SilentlyContinue)) {
        Write-Host "⏳ Instalando $app con Scoop..."
        scoop install $app
    }
}

# 3. Copiar configuración de Neovim
$destNvim = "$env:LOCALAPPDATA\nvim"
if (!(Test-Path $destNvim)) {
    Write-Host "➜ Creando carpeta: $destNvim"
    New-Item -Type Directory -Force -Path $destNvim | Out-Null
}
Write-Host "⏩ Copiando configuración de Neovim..."
Copy-Item -Recurse -Force windows\nvim\* $destNvim\

# 4. Copiar perfil de PowerShell
$profilePath = $PROFILE
$profileDir = Split-Path $profilePath
if (!(Test-Path $profileDir)) {
    Write-Host "➜ Creando carpeta de perfil de PowerShell: $profileDir"
    New-Item -Type Directory -Force -Path $profileDir | Out-Null
}
Write-Host "⏩ Copiando perfil de PowerShell..."
Copy-Item windows\powershell\profile.ps1 $profilePath -Force

# 5. Copiar configuración de Starship
$starshipConfigDir = "$HOME\.config"
if (!(Test-Path $starshipConfigDir)) {
    Write-Host "➜ Creando carpeta: $starshipConfigDir"
    New-Item -Type Directory -Force -Path $starshipConfigDir | Out-Null
}
Write-Host "⏩ Copiando configuración de Starship..."
Copy-Item windows\starship\starship.toml "$starshipConfigDir\starship.toml" -Force

# 6. Instalar módulos de PowerShell necesarios
if (-not (Get-Module -ListAvailable -Name Terminal-Icons)) {
    Write-Host "⏳ Instalando Terminal-Icons..."
    Install-Module -Name Terminal-Icons -Repository PSGallery -Force -Scope CurrentUser
}
if (-not (Get-Module -ListAvailable -Name z)) {
    Write-Host "⏳ Instalando z (jump around directories)..."
    Install-Module -Name z -Repository PSGallery -Force -Scope CurrentUser
}

Write-Host "✅ ¡Configuración completada!"
Write-Host "ℹ️ Reinicia tu terminal para aplicar todos los cambios."
