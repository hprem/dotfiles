from pprint import pprint as pp

try:
    from see import see
except ImportError:
    pass

# Add auto-completion and a stored history file of commands
import atexit
import os
import readline
import rlcompleter

readline.parse_and_bind("tab: complete")
hist_file = "~/.history/python"
if (venv := os.environ.get('VIRTUAL_ENV_PROMPT')):
    hist_file = f"~/.history/python.{venv}.py"
historyPath = os.path.expanduser(hist_file)

def save_history(historyPath=historyPath):
    import readline
    readline.write_history_file(historyPath)

if os.path.exists(historyPath):
    readline.read_history_file(historyPath)

atexit.register(save_history)
del os, atexit, readline, rlcompleter, save_history, historyPath

# vi: ft=python
