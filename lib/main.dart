# -*- coding: utf-8 -*-
"""
أداة إرسال بلاغ إلى support@whatsapp.com
نسخة: واجهة هاكر احترافية (رسم هاكر ينزل + لوحة حمراء بالاسم)
"""

import smtplib
import time
import sys
import os
import re

# محاولة استيراد colorama لتلوين النصوص (Windows & Unix)
try:
    from colorama import init, Fore, Style
    init(autoreset=True)
    RED = Fore.RED + Style.BRIGHT
    DIM_RED = Fore.LIGHTRED_EX + Style.NORMAL
    RESET = Style.RESET_ALL
except Exception:
    # رموز ANSI كاحتياط (قد لا تعمل على بعض البيئات بدون colorama)
    RED = '\033[31;1m'
    DIM_RED = '\033[91m'
    RESET = '\033[0m'

def clear():
    os.system('cls' if os.name == 'nt' else 'clear')

def print_slow(text, delay=0.02):
    for ch in text:
        sys.stdout.write(ch)
        sys.stdout.flush()
        time.sleep(delay)
    print()

# -------- الرسم الأصلي (خلفية بسيطة) --------
SKULL_ART = r'''
                .ed"""" """$$$$be.
              -"           ^""**$$$e.
            ."                   '$$$c
           /                      "4$$b
          d  3                     $$$$
          $  *                   .$$$$$$
         .$  ^c           $$$$$e$$$$$$$$.
         d$L  4.         4$$$$$$$$$$$$$$b
         $$$$b ^ceeeee.  4$$ECL.F*$$$$$$$
         $$$$P d$$$$F $ $$$$$$$$$- $$$$$$
         $$$$P  $$$$  "  $$$$$$$$  $$$$$$
         "$$$$  $$$$b    $$$$$$$$  $$$$"
          $$$$  "$$$$b   $$$$$$$$ $$$"
           $$$L  $$$$b  $$$$$$$ $$$"
            $$$$  $$$$e $$$$$$F $$$
             "$$$c "^$$$$$$$$F $$$
               $$$$be-"*$$$$$$$"
               $$$$$$$$$$$$$$$$$
                "$$$$$$$$$$$$$"
'''

# -------- رسم هاكر احترافي (جمجمة + تأثيرات تقنية) --------
HACKER_IMAGE = r'''
                      .--------.
                     / .------. \
                    / /        \ \
                    | |  .--.  | |
                    | | ( () ) | |
                    | |  '--'  | |
                    | |        | |
                    | |        | |
                    | '--------' |
                    '--------------'
                 .-""-._.--._.--._.-""-.
                /  .--.  .--.  .--.   . \
               /  /    \/    \/    \   \ \
              /  /  /\      /\    /\ \  \ \
             /  /  /  \    /  \  /  \ \  \ \
            /  /  / /\ \  / /\ \/ /\ \ \  \ \
           /  /  / /  \ \/ /  \  /  \ \ \  \ \
          /  /  /_/    \__/    \/    \_\_\  \ \
         /  /________________________________\ \
        /______________________________________\ \
       |   __  __   ___   ___ ___  _   _  _   | |
       |  |  \/  | / _ \ / __/ _ \| | | || |  | |
       |  | |\/| || | | | (_| (_) | |_| || |  | |
       |  |_|  |_| \___/ \___\___/ \___/ |_|  | |
       |                                        |
       |   ██████  █    █  ███╗   ██╗ ██████    |
       |   ██   ██  █  █   ████╗  ██║ ██    ██  |
       |   ██████    ██    ██╔██╗ ██║ ██    ██  |
       |   ██   ██   ██    ██║╚██╗██║ ██    ██  |
       |   ██   ██   ██    ██║ ╚████║  ██████   |
       |                                        |
       '----------------------------------------'
'''

# -------- لوحة باسم المطور ----------
BANNER_NAME = "ꪝ🇾🇪اﻟﻗﻳادﮬꪝ🇾🇪"

def render_banner_box(name, width=54):
    inner = f" {name} "
    pad_total = max(0, width - len(inner))
    left = pad_total // 2
    right = pad_total - left
    # نستخدم مربع بحدود لتبدو كلافتة
    top = "+" + "-"*(width) + "+"
    middle = "|" + " " * left + inner + " " * right + "|"
    bottom = "+" + "-"*(width) + "+"
    return "\n".join([top, middle, bottom])

# -------- تأثير النزول (drop) و التوهج (glow) ----------
def drop_effect_raw(art, steps=10, delay_per_step=0.06, color_prefix="", color_reset=""):
    """
    يعرض الرسم بحيث يبدو أنه ينزل سطرًا بسطر.
    color_prefix, color_reset لإضافة ألوان حول الرسم (مثلاً RED, RESET).
    """
    for i in range(steps):
        clear()
        # نطبع أسطر فارغة تزداد كل مرة ليعطي تأثير النزول
        print("\n" * i + color_prefix + art + color_reset)
        time.sleep(delay_per_step)
    clear()
    print(color_prefix + art + color_reset)

def glow_effect_with_banner(art, name_box, pulses=4, on_time=0.18, off_time=0.12):
    for _ in range(pulses):
        clear()
        print(RED + art + RESET)
        print(RED + name_box + RESET)
        time.sleep(on_time)
        clear()
        print(DIM_RED + art + RESET)
        print(DIM_RED + name_box + RESET)
        time.sleep(off_time)
    clear()
    print(RED + art + RESET)
    print(RED + name_box + RESET)

# -------- دوال العرض المتسلسلة --------
def display_intro_sequence():
    # عرض الرسم الأصلي كخلفية سريعة
    drop_effect_raw(SKULL_ART, steps=6, delay_per_step=0.045)
    # ثم عرض الرسم الهاكر الاحترافي بالأحمر بنزول وتوهّج
    name_box = render_banner_box(BANNER_NAME, width=54)
    drop_effect_raw(HACKER_IMAGE, steps=12, delay_per_step=0.055, color_prefix=RED, color_reset=RESET)
    glow_effect_with_banner(HACKER_IMAGE, name_box, pulses=5, on_time=0.20, off_time=0.10)

def display_info_banner():
    print_slow("🚀 تم تطوير الأداة بواسطة المطور ꪝ🇾🇪اﻟﻗﻳادﮬꪝ🇾🇪", 0.015)
    print_slow("📢 قناة المطور: https://t.me/QJ1_Q", 0.015)
    print_slow("📬 للتواصل مع المطور: @IJX_W", 0.015)
    print('\n' + '='*70)

# ======== تحقق بسيط وصياغة البريد =========
def validate_phone_number(phone):
    pattern = r'^\+\d{8,15}$'
    if not re.match(pattern, phone):
        print_slow('❌ رقم الهاتف غير صحيح. يجب أن يبدأ بـ + ويحتوي على 8-15 رقم')
        return False
    return True

def validate_email(email):
    pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    if not re.match(pattern, email):
        print_slow('❌ البريد الإلكتروني غير صحيح')
        return False
    return True

def send_report_email(sender_email, sender_password, phone, report_type, additional_info):
    try:
        from email.mime.text import MIMEText
        from email.mime.multipart import MIMEMultipart

        msg = MIMEMultipart()
        msg['From'] = sender_email
        msg['To'] = 'support@whatsapp.com'
        msg['Subject'] = 'بلاغ عن رقم واتساب مخالف'

        report_types = {
            "1": "رسائل مزعجة أو ترويجية",
            "2": "احتيال أو نصب",
            "3": "إساءة أو تهديد",
            "4": "حساب وهمي أو انتحال شخصية",
            "5": "خطاب كراهية أو تمييز"
        }

        body = f"""
تفاصيل البلاغ:
- رقم الهاتف المبلغ عنه: {phone}
- نوع البلاغ: {report_types.get(report_type, 'غير محدد')}
- معلومات إضافية: {additional_info}
- مرسل البلاغ: {sender_email}
- تاريخ البلاغ: {time.strftime("%Y-%m-%d %H:%M:%S")}

يرجى التحقيق في هذا البلاغ واتخاذ الإجراء المناسب.
"""
        msg.attach(MIMEText(body, 'plain'))

        with smtplib.SMTP('smtp.gmail.com', 587) as server:
            server.starttls()
            server.login(sender_email, sender_password)
            server.send_message(msg)

        return True

    except Exception as e:
        print_slow(f'❌ خطأ في إرسال البريد: {str(e)}')
        return False

# ======== البرنامج الرئيسي ========
def main():
    try:
        display_intro_sequence()
    except Exception:
        # في حال الطرفية لا تدعم مسح الشاشة أو الألوان، عرض بسيط
        clear()
        print(HACKER_IMAGE)
        print(render_banner_box(BANNER_NAME, width=54))

    display_info_banner()

    print('\n' + '='*50)
    print_slow('متطلبات التشغيل:', 0.02)
    print_slow('1. بريد إلكتروني فعال (يفضل Gmail)', 0.02)
    print_slow('2. تفعيل "التحقق بخطوتين" وإنشاء App Password لـ Gmail', 0.02)
    print_slow('3. معرفة الرقم المستهدف (بمفتاح الدولة)', 0.02)
    print('='*50)

    print('\n' + '='*50)
    print_slow('البيانات المطلوبة لإرسال البلاغ:', 0.02)

    while True:
        sender_email = input('بريدك الإلكتروني (لإرسال البلاغ): ')
        if validate_email(sender_email):
            break

    sender_password = input('كلمة مرور البريد الإلكتروني أو App Password (لن يتم تخزينها): ')

    print('\n' + '='*50)
    print_slow('اختر نوع البلاغ:', 0.02)
    print('1. رسائل مزعجة أو ترويجية')
    print('2. احتيال أو نصب')
    print('3. إساءة أو تهديد')
    print('4. حساب وهمي أو انتحال شخصية')
    print('5. خطاب كراهية أو تمييز')
    print('='*50)

    while True:
        report_type = input('اختر رقم البلاغ (1-5): ')
        if report_type in ['1', '2', '3', '4', '5']:
            break
        print_slow('❌ الرجاء اختيار رقم بين 1 و 5', 0.02)

    while True:
        phone_number = input('رقم الهاتف للإبلاغ عنه (بمفتاح الدولة مثل +96650XXXXXXX): ')
        if validate_phone_number(phone_number):
            break

    additional_info = input('معلومات إضافية (اختياري): ') or 'لا توجد معلومات إضافية'

    print('\n' + '='*50)
    print_slow('تفاصيل البلاغ:', 0.02)
    print(f'المرسل: {sender_email}')
    print(f'الرقم المبلغ عنه: {phone_number}')
    print(f'نوع البلاغ: {report_type}')
    print(f'معلومات إضافية: {additional_info}')
    print('='*50)

    confirm = input('هل تريد إرسال البلاغ الآن؟ (نعم/لا): ').strip().lower()
    if confirm not in ['نعم', 'yes', 'y']:
        print_slow('تم إلغاء عملية الإرسال', 0.02)
        return

    print_slow('\nجاري إرسال البلاغ الرسمي إلى واتساب...', 0.02)

    if send_report_email(sender_email, sender_password, phone_number, report_type, additional_info):
        print_slow('✅ تم إرسال البلاغ بنجاح إلى support@whatsapp.com', 0.02)
        print_slow('سيتم مراجعة بلاغك خلال 3-5 أيام عمل', 0.02)
    else:
        print_slow('❌ فشل في إرسال البلاغ، يرجى المحاولة لاحقاً', 0.02)

    print('\n' + '='*50)
    print_slow('تنويهات قانونية:', 0.02)
    print_slow('1. الإبلاغ الكاذب قد يعرضك للمساءلة القانونية', 0.02)
    print_slow('2. سيتم تسجيل عنوان IP الخاص بك مع البلاغ', 0.02)
    print_slow('3. هذه الأداة للاستخدام القانوني فقط', 0.02)

if __name__ == '__main__':
    main()