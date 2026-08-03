import asyncio
from telegram import Bot
from datetime import datetime
import schedule
import time
import sys
from config import BOT_TOKEN, CHAT_ID, MESSAGE, SEND_TIME

bot = Bot(token=BOT_TOKEN)

async def send_daily_message():
    try:
        await bot.send_message(chat_id=CHAT_ID, text=MESSAGE)
        print(f"[{datetime.now()}] ✓ Сообщение отправлено пользователю {CHAT_ID}")
        sys.stdout.flush()
    except Exception as e:
        print(f"[{datetime.now()}] ✗ Ошибка при отправке: {e}")
        sys.stdout.flush()

def schedule_task():
    schedule.every().day.at(SEND_TIME).do(lambda: asyncio.run(send_daily_message()))
    print(f"[{datetime.now()}] ✓ Бот запущен. Сообщение в {SEND_TIME} ежедневно")
    sys.stdout.flush()

    while True:
        try:
            schedule.run_pending()
            time.sleep(60)
        except Exception as e:
            print(f"[{datetime.now()}] Ошибка в цикле: {e}")
            sys.stdout.flush()
            time.sleep(60)

if __name__ == "__main__":
    try:
        schedule_task()
    except KeyboardInterrupt:
        print(f"\n[{datetime.now()}] Бот остановлен вручную")
    except Exception as e:
        print(f"[{datetime.now()}] Критическая ошибка: {e}")
        time.sleep(30)
