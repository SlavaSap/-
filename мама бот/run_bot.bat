@echo off
REM Запуск Telegram бота мама бот 24/7 с автоперезагрузкой

:loop
echo.
echo =====================================
echo  Запуск бота мама бот...
echo  Время: %date% %time%
echo =====================================
echo.

cd /d "C:\Users\three\PycharmProjects\PythonProject\мама бот"

REM Установка Python пути
python -c "import sys; print('Python найден:', sys.executable)" >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Python не установлен или не в PATH
    pause
    exit /b 1
)

REM Установка зависимостей
echo Проверка зависимостей...
pip install -r requirements.txt --quiet

REM Запуск бота
python main.py

echo.
echo !!!!! БОТ ЗАВЕРШИЛСЯ !!!!
echo Перезагрузка через 30 секунд...
echo.

timeout /t 30 /nobreak

goto loop

pause
