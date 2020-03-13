# This plugin adds opened files to `fasd`

from __future__ import (absolute_import, division, print_function)

import subprocess

import ranger.api
from ranger.ext.spawn import check_output

HOOK_INIT_OLD = ranger.api.hook_init

def hook_init(fm):
    def sig_cd(sig):
        print("\033]0;ranger: {}\007".format(sig.new), end='', flush=True)
    def sig_exe(sig):
        print("\033]0;runner: {}\007".format(sig.origin.__dict__), end='', flush=True)
    fm.signal_bind('cd', sig_cd)
    # fm.signal_bind('execute.before', sig_exe)
    return HOOK_INIT_OLD(fm)

ranger.api.hook_init = hook_init
