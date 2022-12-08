project('Blackjack', 'c', 'fortran')

blackjack = library('blackjack',
sources: ['src/blackjack.f90', 'src/shuffler.f90'])

executable('c_blackjack', 'src/blackjack.c', link_with : blackjack)
executable('f_blackjack', 'app/main.f90', link_with : blackjack)

py3 = find_program('python3')

test('C', py3,
  args : ['-m', 'pytest', '-k', 'c', '-v'],
  workdir : meson.source_root() / 'tests')

test('Fortran', py3,
  args : ['-m', 'pytest', '-k', 'fortran', '-v'],
  workdir : meson.source_root() / 'tests')
