from RestrictedPython import compile_restricted
from RestrictedPython import safe_builtins

source_code = "import this"

context = {}
try:
    byte_code = compile_restricted(source_code, '<inline>', 'exec')
    exec(byte_code, {'__builtins__': safe_builtins}, context)
except SyntaxError as e:
    raise e
