from RestrictedPython import compile_restricted
from RestrictedPython import RestrictingNodeTransformer

class OwnRestrictingNodeTransformer(RestrictingNodeTransformer):
    def visit_Import(self, node):
        self.error(node, 'Import statements are not allowed.')
    visit_ImportFrom = visit_Import

source_code = "import this"

try:
    byte_code = compile_restricted(
        source=source_code,
        filename='<inline>',
        mode='exec',
        policy=OwnRestrictingNodeTransformer)
    exec(byte_code)
except SyntaxError as e:
    raise e
