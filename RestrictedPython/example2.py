from RestrictedPython import compile_restricted
from RestrictedPython import safe_builtins

source_code = """
def add(x):
  return x + 1
"""

context = {}
try:
    byte_code = compile_restricted(source_code, '<inline>', 'exec')
    exec(byte_code, safe_builtins, context)
except SyntaxError as e:
    raise e

assert 2 == context['add'](1)
