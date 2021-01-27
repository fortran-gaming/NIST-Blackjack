# NIST Blackjack

![Actions Status](https://github.com/fortran-gaming/NIST-blackjack/workflows/ci/badge.svg)

For a study on cyclomatic complexity and methods to detect errors, Fortran and C code were provided by NIST.
That code had syntax errors bad enough to not compile in contemporary compilers, so the syntax errors were fixed.
Also, function "Mix" that shuffles the cards was not defined in the article; we provide
[Fisher-Yates Shuffle](https://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle)
algorithm for this.

## Build

```sh
cmake -B build

cmake --build build
```

Then run the respective programs by

```sh
build/f_blackjack
```

or

```sh
build/c_blackjack
```

For `f_blackjack` the command line flag `-d` enables debug mode, where you can set the value of the next card.

## Implementations

As noted in the summary, we provided syntax corrections to the original code, which was not usable otherwise

### C

The 1996 NIST 500-235
[publication](https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication500-235.pdf)
"Structured Testing: A Testing Methodology Using the Cyclomatic Complexity Metric"
tries to do a line-by-line conversion from Fortran.
We fixed the syntax errors in [blackjack.c](./blackjack.c) and use the Fortran implementations of Mix and Hit in the C program.

### Fortran 90

The
[1982 NIST 500-99 publication](https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nbsspecialpublication500-99.pdf)
"Structured Testing: A Software Testing Methodology Using the Cyclomatic Complexity Metric"
did a legacy FORTRAN implementation that was needlessly verbose and wasn't easily usable from C.
We minimally updated the NIST blackjack code to Fortran 90 syntax, using Fortran 2003 `bind(c)` for convenience, as is generally recommended.
The [reusable code](./blackjack.f90) and main Fortran [program](./main.f90) are provided here and compatible with any Fortran compiler.
