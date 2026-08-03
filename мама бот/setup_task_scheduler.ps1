# Скрипт для добавления бота в Task Scheduler Windows
# Запустить от администратора: powershell -ExecutionPolicy Bypass -File setup_task_scheduler.ps1

$scriptPath = "C:\Users\three\PycharmProjects\PythonProject\мама бот\start_bot_hidden.vbs"
$taskName = "Mama Bot Auto Start"
$taskDescription = "Автоматический запуск Telegram бота Мама Бот"

# Проверка прав администратора
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
if (-not $isAdmin) {
    Write-Host "ОШИБКА: Требуются права администратора!" -ForegroundColor Red
    Write-Host "Запустите PowerShell от имени администратора"
    Read-Host "Нажмите Enter для выхода"
    exit
}

# Удалить старую задачу если существует
Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue | Unregister-ScheduledTask -Confirm:$false

# Создать действие (запустить файл)
$action = New-ScheduledTaskAction -Execute "wscript.exe" -Argument "`"$scriptPath`""

# Создать триггер (при запуске системы)
$trigger = New-ScheduledTaskTrigger -AtStartup

# Создать параметры задачи
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -RunWithoutNetwork -ExecutionTimeLimit 0

# Создать задачу
Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Settings $settings -Description $taskDescription -RunLevel Highest

Write-Host "✓ Задача Task Scheduler успешно создана!" -ForegroundColor Green
Write-Host "Название: $taskName"
Write-Host "Бот будет запускаться при каждой загрузке Windows"
Write-Host ""
Write-Host "Для проверки: taskscheduler > Библиотека планировщика задач > просмотрите '$taskName'"
Write-Host ""
Read-Host "Нажмите Enter для выхода"
