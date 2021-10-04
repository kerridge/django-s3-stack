#!/usr/bin/env python
import os
import sys

if __name__ == "__main__":
    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "headless_test.settings.dev")

    from django.conf import settings

    if settings.DEBUG:
        if os.environ.get('RUN_MAIN') or os.environ.get('WERKZEUG_RUN_MAIN'):
            import ptvsd

            ptvsd.enable_attach(address=('0.0.0.0', 3000))
            print('Waiting for debugger to attach, try launching `Run Django` debug configuration')
            ptvsd.wait_for_attach()
            print('Attached!')

    from django.core.management import execute_from_command_line

    execute_from_command_line(sys.argv)