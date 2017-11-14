#!/usr/bin/env python3
import json
from subprocess import check_output as co

workspaces = json.loads(co(['i3-msg', '-t', 'get_workspaces']).decode('utf-8'))

first_free_workspace = sorted(set(range(1, len(workspaces) + 2)) -
                              {ws["num"] for ws in workspaces})[0]

co(['i3-msg',
   'move container to workspace number {}'.format(first_free_workspace)])

co(['i3-msg',
   'workspace {}'.format(first_free_workspace)])
