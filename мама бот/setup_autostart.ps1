# Скрипт для добавления бота в автозапуск Windows
# Запустить от администратора: powershell -ExecutionPolicy Bypass -File setup_autostart.ps1

$scriptPath = "C:\Users\three\PycharmProjects\PythonProject\мама бот\start_bot_hidden.vbs"
$startupFolder = $env:APPDATA + "\Microsoft\Windows\Start Menu\Programs\Startup"
$shortcutPath = $startupFolder + "\Мама Бот.lnk"

# Проверка прав администратора
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
if (-not $isAdmin) {
    Write-Host "ОШИБКА: Требуются права администратора!" -ForegroundColor Red
    Write-Host "Запустите PowerShell от имени администратора"
    Read-Host "Нажмите Enter для выхода"
    exit
}

# Создание ярлыка
$WshShell = New-Object -ComObject WScript.Shell
$shortcut = $WshShell.CreateShortcut($shortcutPath)
$shortcut.TargetPath = $scriptPath
$shortcut.Description = "Мама Бот - Telegram бот"
$shortcut.Save()

Write-Host "✓ Бот успешно добавлен в автозапуск!" -ForegroundColor Green
Write-Host "Бот будет автоматически запускаться при каждой загрузке Windows"
Write-Host ""
Write-Host "Путь ярлыка: $shortcutPath"
Write-Host ""
Read-Host "Нажмите Enter для выхода"
