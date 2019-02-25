#!/usr/bin/env python
import subprocess
from pathlib import Path
import pytest

R = Path(__file__).resolve().parents[1] / 'build'


def test_c():

    proc = subprocess.Popen('./c_blackjack', cwd=R, text=True,
                            stdin=subprocess.PIPE)

    ret = None
    while ret is None:
        proc.stdin.write('y\n')
        ret = proc.poll()

    assert ret == 0


def test_fortran():

    proc = subprocess.Popen('./f_blackjack', cwd=R, text=True,
                            stdin=subprocess.PIPE)

    ret = None
    while ret is None:
        proc.stdin.write('y\n')
        ret = proc.poll()

    assert ret == 0


if __name__ == '__main__':
    pytest.main(['-v', __file__])
