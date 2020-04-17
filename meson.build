project('Blackjack', 'c', 'fortran',
default_options : ['default_library=static, warning_level=3'])

blackjack = library('blackjack', 'blackjack.f90')
executable('c_blackjack', 'blackjack.c', link_with : blackjack)
executable('f_blackjack', 'main.f90', link_with : blackjack)

py3 = find_program('python3')

test('C', py3,
  args : ['-m', 'pytest', '-k', 'c', '-v'],
  workdir : meson.source_root() / 'tests')

test('Fortran', py3,
  args : ['-m', 'pytest', '-k', 'fortran', '-v'],
  workdir : meson.source_root() / 'tests')
