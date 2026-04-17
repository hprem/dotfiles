from pprint import pprint as pp
import os, sys
import code
import atexit
import readline
import rlcompleter
import pdb

# Autocomplete on pressing tab
print('Runing cmds from ~/.pdbrc.py')
print ("Setting up readline")
vars = locals()|globals()
readline.set_completer(rlcompleter.Completer(vars).complete)
readline.parse_and_bind("tab: complete")

# History Support
histfile = os.path.expanduser('~/.history/pdb')

if os.path.isfile(histfile):
    readline.read_history_file(histfile)

def write_hist_file():
    try:
        readline.write_history_file(histfile)
    except IOError:
        pass

atexit.register(write_hist_file)
readline.set_history_length(10 * 1000)

# We are using pdb++
# https://github.com/pdbpp/pdbpp/blob/master/pdbrc.py
class Config(pdb.DefaultConfig):

    editor = 'e'
    stdin_paste = 'epaste'
    filename_color = pdb.Color.lightgray
    use_terminal256formatter = False

    def __init__(self):
        try:
            from pygments.formatters import terminal
        except ImportError:
            print ('Missing pygments. Not init-ing color support')
            pass
        else:
            self.colorscheme = terminal.TERMINAL_COLORS.copy()
            self.colorscheme.update({
                terminal.Keyword:            ('darkred',     'red'),
                terminal.Number:             ('darkyellow',  'yellow'),
                terminal.String:             ('brown',       'green'),
                terminal.Name.Function:      ('darkgreen',   'blue'),
                terminal.Name.Namespace:     ('teal',        'cyan'),
                })

# Source .pdbrc.py from current working dir
pdbrc = os.path.join(os.getcwd(), '.pdbrc.py')
if os.path.exists(pdbrc):
    cur_dir = os.getcwd().replace(os.path.expanduser('~'), '~', 1)
    #print(f'Runing cmds from {cur_dir}/.pdbrc.py')
    with open(pdbrc) as fh:
        exec(fh.read())
# vi: ft=python
