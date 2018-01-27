import os
from datetime import datetime, timedelta
import re
import calendar_events


AGENDA = True

now = datetime.now()
nextMonth = now + timedelta(days=30)

from ansicolor import *

abspath = os.path.abspath(__file__)
dname = os.path.dirname(abspath)
os.chdir(dname)

def center(s, width_):
    length = len(strip_escapes(s))
    return ('.'*length).center(width_).replace('.'*length, s)

def left_align(s, width_):
    length = len(strip_escapes(s))
    return ('.'*length).ljust(width_).replace('.'*length, s)

def right_align(s, width_):
    length = len(strip_escapes(s))
    return ('.'*length).rjust(width_).replace('.'*length, s)

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
    logoGroups = re.compile('(.+─ )(.+?)( ─.+)').split(line)
    textGroups = re.compile('(.*│)(.+?)(│.*)').split(line)
    groups = None
    if len(logoGroups)==5:
        groups = logoGroups
    elif len(textGroups)==5:
        groups = textGroups

    if groups is not None:
        return bg_color(groups[1]) + fg_color(groups[2]) + bg_color(groups[3])
    else:
        return bg_color(line)

with open('banner.txt', 'r+') as f:
    for banner_line in f.read().split('\n'):
        messages.append(map_banner_line(banner_line, yellow, white))

def get_events():
    events_raw = calendar_events.get_events()
    summaries = [event[0] for event in events_raw]
    dates = [event[1] for event in events_raw]
    maxDateLength = max(map(len, dates))
    padded_dates = map(lambda date: right_align(date, maxDateLength), dates)

    _events = [yellow(date)+red(' │ ')+blue(summary) for summary, date in zip(summaries, padded_dates)]
    _events_length = max(map(lambda event: len(strip_escapes(event)), _events))
    _events_padded = [left_align(event, _events_length) for event in _events]
    return _events_padded, _events_length

messages.append(yellow('Hi there, ') + red(os.environ['USER'].title()) + yellow('!'))
messages.append('')

if AGENDA:
    messages.append(green('Upcoming events:'))
    events, events_length = get_events()
    for event in events:
        messages.append(left_align(event, events_length))
    messages.append(white(''))

append_all([
  yellow('Today is ') + blue('{} the {} of {}'.format(now.strftime('%A'), ordinal(now.day), now.strftime('%B'))) + yellow('.'),
  yellow('It is ') + blue(now.strftime('%I:%M %p')) + yellow('.'),
  '',
  green('Happy scripting!')
])

width = max(map(lambda message: len(strip_escapes(message)), messages))+6
TOP_DIV = '  ' + blue('╒' + '═'*(width-2) + '╕')
BOT_DIV = '  ' + blue('╘' + '═'*(width-2) + '╛')

print()
print(TOP_DIV)
print()
for message in messages:
    print('  '+center(message, width))
print()
print(BOT_DIV)
print()

