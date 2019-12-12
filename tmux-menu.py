#!/usr/bin/env python3

import os
import shlex
from argparse import ArgumentParser
from io import StringIO
from pathlib import Path
from subprocess import run, PIPE
from sys import exit
from time import sleep

TMUX_DIR = Path(__file__).parent
BASE_DIR = Path('.')
ENV_FILES = [
    Path('.env/bin/activate.fish'),
    Path('my.fish-env'),
]

def cat_menu():
    menu = ''
    for p in [TMUX_DIR/'tmux-menu.txt', BASE_DIR/'my.tmux-menu']:
        if p.exists():
            menu += p.read_text()
    return menu

def show_menu():
    menu = cat_menu()
    p = run(['fzf', '--no-sort', '--layout=reverse', '--prompt=Command: '],
            input=menu, stdout=PIPE, encoding='utf-8')
    if p.returncode != 0:
        exit(0)
    return p.stdout.strip()

def parse_command(s):
    title, _, cmd = s.partition('::')
    return title.strip(), cmd.strip()

def parse_args():
    p = ArgumentParser()
    p.add_argument('-t', '--set-title', action='store_true', help='Set tmux title')
    return p.parse_args()

def run_command(cmd):
    fish_cmd = ['fish']

    for env_file in ENV_FILES:
        if env_file.exists():
            fish_cmd += ['-C', f'source "{env_file}"']

    if ' ' not in cmd and Path(cmd).is_dir():
        run([*fish_cmd, '-C', f'cd "{cmd}"', '-c', 'exec fish'])
    else:
        p = run([*fish_cmd, '-c', f'exec {cmd}'])
        if p.returncode != 0:
            print('----')
            print(f'Command exited with code {p.returncode}')
            input()

def main():
    args = parse_args()
    if args.set_title:
        run(['tmux', 'rename-window', 'Run...'], check=True)

    menu_result = show_menu()
    title, cmd = parse_command(menu_result)

    if args.set_title:
        run(['tmux', 'rename-window', title], check=True)

    run_command(cmd)

if __name__ == '__main__':
    main()

