# Configuración optimizada para PowerShell con mejor rendimiento y funcionalidad

# === Configuración de PSReadLine ===
# Habilitar IntelliSense predictivo basado en historial
Set-PSReadLineOption -PredictionSource History
# Vista de lista para las predicciones (alternativas: InlineView o ListView)
Set-PSReadLineOption -PredictionViewStyle ListView
# Colorear la predicción para mejor visibilidad
Set-PSReadLineOption -Colors @{ InlinePrediction = "#808080" }

# === Navegación mejorada en el historial ===
# Búsqueda en historial con flechas (mantiene el contexto de lo que has escrito)
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
# Ctrl+R para búsqueda avanzada en historial (similar a la funcionalidad básica de Atuin)
Set-PSReadLineKeyHandler -Key Ctrl+r -Function ReverseSearchHistory

# === Mejoras de rendimiento ===
# Reducir el tamaño máximo del historial para mejor rendimiento
Set-PSReadLineOption -MaximumHistoryCount 2000
# Habilitar la búsqueda de historial sensible a la posición del cursor
Set-PSReadLineOption -HistorySearchCursorMovesToEnd

# === Atajos de teclado productivos ===
# Ctrl+Space para aceptar sugerencia (más rápido que flecha derecha)
Set-PSReadLineKeyHandler -Key Ctrl+Spacebar -Function AcceptSuggestion
# Ctrl+E para ir al final de la línea (como en Unix)
Set-PSReadLineKeyHandler -Key Ctrl+e -Function EndOfLine
# Ctrl+A para ir al inicio de la línea (como en Unix)
Set-PSReadLineKeyHandler -Key Ctrl+a -Function BeginningOfLine
# Alt+F para avanzar una palabra (como en Unix)
Set-PSReadLineKeyHandler -Key Alt+f -Function ForwardWord
# Alt+B para retroceder una palabra (como en Unix)
Set-PSReadLineKeyHandler -Key Alt+b -Function BackwardWord

# === Integración con Starship (si lo tienes instalado) ===
# Instala Starship primero con: scoop install starship
Invoke-Expression (&starship init powershell)

# === Alias útiles para desarrollo ===
Set-Alias -Name vim -Value nvim
Set-Alias -Name ll -Value ls
Set-Alias -Name g -Value git
function gs { git status }
function nv { nvim . }

# === Mejora de rendimiento en la carga ===
# Cargar solo los módulos necesarios
$env:POWERSHELL_UPDATECHECK = "Off"  # Desactivar verificación de actualizaciones para inicios más rápidos

Import-Module Terminal-Icons

# Autocompletado más inteligente
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete