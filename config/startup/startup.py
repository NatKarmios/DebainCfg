import os
from datetime import datetime, timedelta
import re
import subprocess

AGENDA = False

now = datetime.now()
nextMonth = now + timedelta(days=30)

from ansicolor import *

abspath = os.path.abspath(__file__)
dname = os.path.dirname(abspath)
os.chdir(dname)

def center(s, width_):
    length = len(strip_escapes(s))
    return ("."*length).center(width_).replace("."*length, s)

def left_align(s, width_):
    length = len(strip_escapes(s))
    return ("."*length).ljust(width_).replace("."*length, s)

SUFFIXES = {1: 'st', 2: 'nd', 3: 'rd'}
def ordinal(num):
    if 10 <= num % 100 <= 20:
        suffix = 'th'
    else:
        suffix = SUFFIXES.get(num % 10, 'th')
    return str(num) + suffix

messages = []
def append_all(ls):
    for i in ls:
        messages.append(i)


def map_banner_line(line, bg_color, fg_color):
    logoGroups = re.compile("(.+─ )(.+?)( ─.+)").split(line)
    textGroups = re.compile("(.*│)(.+?)(│.*)").split(line)
    groups = None
    if len(logoGroups)==5:
        groups = logoGroups
    elif len(textGroups)==5:
        groups = textGroups

    if groups is not None:
        return bg_color(groups[1]) + fg_color(groups[2]) + bg_color(groups[3])
    else:
        return bg_color(line)

with open("banner.txt", "r+") as f:
    for banner_line in f.read().split("\n"):
        messages.append(map_banner_line(banner_line, yellow, white))

def get_events():
    events_raw = subprocess.check_output(['gcalcli', 'agenda', now.strftime("%Y%m%d"), nextMonth.strftime("%Y%m%d")]).decode()

    _events = list(map(lambda event: red("│  ")+event, 
        filter(lambda event: strip_escapes(event).strip()!="" and "\x1b[0;35m" not in event, 
            events_raw.split("\n"))))
    _events_length = max(map(lambda event: len(strip_escapes(event)), events))
    return _events, _events_length


messages.append("Hi there, {}!".format(red(os.environ["USER"].title())))
messages.append("")

if AGENDA:
    messages.append(green("Upcoming events:"))
    events, events_length = get_events()
    for event in events:
        messages.append(left_align(event, events_length))
    messages.append(white(""))

append_all((
  "Today is "+ blue("{} the {} of {}".format(now.strftime("%A"), ordinal(now.day), now.strftime("%B"))) + ".",
  "It is {}.".format(blue(now.strftime("%I:%M %p"))),
  "",
  yellow("Happy scripting!")
))

width = max(map(lambda message: len(strip_escapes(message)), messages))+6
top_div = lambda: print("  " + blue("╒" + "═"*(width-2) + "╕"))
bot_div = lambda: print("  " + blue("╘" + "═"*(width-2) + "╛"))

print()
top_div()
print()
for message in messages:
    print("  "+center(message, width))
print()
bot_div()
print()

