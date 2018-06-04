from RestrictedPython import compile_restricted

source_code = """
def add(x):
  return x + 1
"""

context = {}
try:
    byte_code = compile_restricted(
        source_code,
        filename='<inline>',
        mode='exec')
    exec(byte_code, None, context)
except SyntaxError as e:
    raise e

assert 2 == context['add'](1)
