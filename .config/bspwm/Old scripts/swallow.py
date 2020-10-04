#!/usr/bin/env python
'''
Swallow function for bspwm
when spawning a child process hide the parent window
WARNING: not tested on multiple monitors setup
'''

import os
import re
import sys
import json
import logging
import traceback
import subprocess
from functools import partial


EXCLUDED_CLASSES = ['qutebrowser', 'xev', 'lemonbar', 'xfce4-panel']

logging_level = logging.ERROR if len(sys.argv) == 1 else sys.argv[1]
logging.basicConfig(filename=os.path.expanduser('~/.swallow.log'),
                    level=logging_level)

cmd_run = partial(subprocess.Popen, text=True, shell=True)


def get_class(wid):
    '''lemonbar
    get passed window id class using xprop output
    '''
    try:
        out = cmd_output(f'xprop -id {wid}')
        wids = re.search(r'^wm_class\(string\)\s=\s(.*?)$', out,
                         flags=re.IGNORECASE | re.MULTILINE).group(1)
        wids = [wid.strip('"') for wid in wids.split(', ')][1]
        logging.debug(f'get_class output: {wids} {out} {wid}')
        return wids
    except Exception as e:
        logging.debug(f'Error in get_class: {wid}: {e}')
        return ''


def cmd_output(cmd):
    '''
    subprocess's check output with some defaults and exception handling
    '''
    try:
        out = subprocess.check_output(cmd, text=True, shell=True).strip()
    except Exception:
        out = ''
    return out


def execute(cmd):
    '''
    execute and yield the output
    '''
    popen = subprocess.Popen(cmd, stdout=subprocess.PIPE,
                             universal_newlines=True, text=True, shell=True)
    for stdout_line in iter(popen.stdout.readline, ""):
        yield stdout_line
    popen.stdout.close()
    return_code = popen.wait()
    if return_code:
        raise subprocess.CalledProcessError(return_code, cmd)


def desk_layout():
    '''
    return True if desktop is monocle
    '''
    return json.loads(cmd_output('bspc query -T -d'))['layout']


def is_fullscreen(wid):
    '''
    check whether passed window id refers to a fullscreen window
    '''
    return cmd_output(f'bspc query -N -n {wid}.fullscreen').strip()


def is_floating(wid):
    '''
    check whether passed window id refers to a floating window
    '''
    return cmd_output(f'bspc query -N -n {wid}.floating').strip()


def get_pid(wid):
    '''
    get window process id using xprop output
    '''
    out = cmd_output(f'xprop -id {wid} | grep WM_PID')
    if out:
        return out.split(' = ')[1]
    else:
        return ''


def is_child(pid, child_pid):
    '''
    check whether child_pid is a child of pid
    '''
    tree = cmd_output(f'pstree -T -p {pid}')
    for line in tree.split('\n'):
        if child_pid in line:
            return True
    return False


def swallow_cond(new_wid, last_wid):
    '''
    True if window should be swallowed False if not
    Modify it to your liking
    '''
    logging.debug(f'swallow_cond: {new_wid} {last_wid}')
    if desk_layout() == 'monocle':
        logging.debug('current desktop is monocle returning False')
        return False
    is_excluded = [c for c in EXCLUDED_CLASSES
                   if any(c in get_class(id)
                          for id in (new_wid, last_wid))]
    if is_excluded:
        return False
    if any((is_floating(new_wid), is_floating(last_wid),
            is_fullscreen(new_wid), is_fullscreen(last_wid),
            is_excluded)):
        return False
    return True


def swallow():
    '''
    monitore node_add and node_remove events and store swallowed
    windows in a dictionary
    '''
    swallowed = {}
    for event in execute('bspc subscribe node_add node_remove'):
        try:
            logging.debug(f'Processing Event: {event}')
            event = event.split()
            if not event:
                continue
            if event[0] == 'node_add':
                new_wid = event[-1]
                last_wid = cmd_output('bspc query -N -d -n last.window')
                if not swallow_cond(new_wid, last_wid):
                    continue
                new_pid = get_pid(new_wid)
                last_pid = get_pid(last_wid)
                if not all([new_pid, last_pid]):
                    continue
                if is_child(last_pid, new_pid):
                    cmd_run(f'bspc node {last_wid} --flag private=on')
                    cmd_run(f'bspc node --swap {last_wid} --follow')
                    cmd_run(f'bspc node {last_wid} --flag hidden=on')
                    cmd_run(f'bspc node {new_wid} --flag private=on')
                    swallowed[new_wid] = last_wid
            if event[0] == 'node_remove':
                removed_wid = event[-1]
                if removed_wid in swallowed.keys():
                    swallowed_id = swallowed[removed_wid]
                    cmd_run(f'bspc node {swallowed_id} --flag hidden=off')
                    cmd_run(f'bspc node --focus {swallowed_id}')
        except Exception as e:
            logging.debug('Error occured in mainloop:'
                          f'\n{e}\n{traceback.format_exc()}')


if __name__ == '__main__':
    try:
        swallow()
    except Exception as e:
        logging.debug('Error occured in mainloop:'
                      f'\n{e}\n{traceback.format_exc()}')
