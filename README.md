# fortran-proj1

_First assignment for fortran academic course._

## Brief description
The program solves differential equation of heat transport and calculates error relative to expected result.

## Build
`make all KIND=x` where `x` is desired kind (4, 8, 16)

## Usage
`./out/main n` where `n` is range resolution.

### Output
Output is a list of: `<kind> <i> <error>`

The last line is: `<kind> <n> <average error>`

## Results

Graphs of error results for different kinds are to be found in Plots.ipynb notebook (can be viwed via GitHub).
