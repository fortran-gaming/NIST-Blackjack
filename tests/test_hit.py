#!/usr/bin/env python
import subprocess
from pathlib import Path
import sys


exe = sys.argv[1]
if not Path(exe).is_file():
    raise FileNotFoundError(f"{exe} not found")

proc = subprocess.Popen(exe, text=True, stdin=subprocess.PIPE)

ret = None
while ret is None:
    proc.communicate(input='y\n')
    ret = proc.poll()

assert ret == 0
