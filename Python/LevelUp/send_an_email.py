"""My Solution"""
import os
import smtplib
from dotenv import load_dotenv
load_dotenv()

EMAIL = os.environ.get('EMAIL')
PASSWORD = os.environ.get('PASSWORD')

def send_email(dest_address, subject, message):
    server = smtplib.SMTP('smtp.gmail.com', 587)
    server.starttls()
    server.login(EMAIL, PASSWORD)
    server.sendmail(EMAIL, dest_address, f'Subject: {subject}\n\n{message}')
    server.close()
    print(f'Email sent to {dest_address}')

"""Instructor's Solution"""
import smtplib

SENDER_EMAIL = 'YOUR_EMAIL@EMAIL.COM'  # replace with your email address
SENDER_PASSWORD = 'YOUR_PASSWORD'  # replace with your email password

def send_email(receiver_email, subject, body):
    message = f'Subject: {subject}\n\n{body}'
    with smtplib.SMTP('smtp.office365.com', 587) as server:
        server.starttls()
        server.login(SENDER_EMAIL, SENDER_PASSWORD)
        server.sendmail(SENDER_EMAIL, receiver_email, message)

"""Thoughts:
Pretty much the same code, I just incorporated env variables and added a console
message once email was sent.
"""
