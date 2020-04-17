#!/usr/bin/env python
import subprocess
from pathlib import Path
import pytest
import shutil

R = Path(__file__).resolve().parents[1] / 'build'


def test_c():

    exe = shutil.which('c_blackjack', path=str(R))
    if exe is None:
        raise FileNotFoundError("C blackjack not found")

    proc = subprocess.Popen(exe, cwd=R, text=True, stdin=subprocess.PIPE)

    ret = None
    while ret is None:
        proc.communicate(input='y\n')
        ret = proc.poll()

    assert ret == 0


def test_fortran():

    exe = shutil.which('f_blackjack', path=str(R))
    if exe is None:
        raise FileNotFoundError("Fortran blackjack not found")

    proc = subprocess.Popen(exe, text=True, stdin=subprocess.PIPE)

    ret = None
    while ret is None:
        proc.communicate(input='y\n')
        ret = proc.poll()

    assert ret == 0


if __name__ == '__main__':
    pytest.main([__file__])
