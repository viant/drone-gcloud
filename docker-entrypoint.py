#!/usr/bin/python

import os
import sys
import subprocess

os_vars = [
    'GKE_BASE64_KEY',
    'ZONE'
    ]

for os_var in os_vars:
    plugin_var = "PLUGIN_" + os_var
    if plugin_var in os.environ:
        os.environ[os_var] = os.environ[plugin_var]
    if os_var not in os.environ:
        print "%s or %s environment variable required" %(os_var, plugin_var)
        sys.exit(1)

# Optional 
if "PLUGIN_SCRIPT" in os.environ:
    os.environ["SCRIPT"] = os.environ["PLUGIN_SCRIPT"]

# Print debug messages if enabled
if "PLUGIN_DEBUG" in os.environ:
    os.environ['DEBUG'] = "True"
    for os_var in os_vars:
        if os_var == "GKE_BASE64_KEY" and "PLUGIN_DEBUG_BASE64" not in os.environ:
            continue
        print "%s : %s" % (os_var, os.environ[os_var])
    for plugin_var in os.environ:
        if plugin_var[:6] == "PLUGIN":
            if os_var == "PLUGIN_GKE_BASE64_KEY" and "PLUGIN_DEBUG_BASE64" not in os.environ:
                continue
            print "%s : %s" % (plugin_var, os.environ[plugin_var])

if subprocess.call(sys.argv[1:]) is not 0:
    sys.exit(1)
