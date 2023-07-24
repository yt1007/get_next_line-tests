# get_next_line-tests
A set of tests written to test the 42 school project get_next_line submissions

## Installation
Clone the repository to your computer. Then, edit the `GNL_DIR` variable in the `tests/auto.sh` file to point to the directory containing your get_next_line project files.

## Running the Tests
In the repository, type:
1. `make` or `make mandatory` to run tests on mandatory functions. The tester will build your get_next_line using the mandatory files.
2. `make bonus` to run tests on bonus functions. The tester will build your get_next_line using the bonus files.
3. `make all` to run tests on all functions. The tester will build your get_next_line using the mandatory and bonus files.

## Notes
1. This test checks for norminette error for all *.h and *.c files. If you have other non-get_next_line files with a .h or .c suffix, these files will also be checked.
2. One of the tests checks your get_next_line submission by calling get_next_line on the stdin (file description 0), the test does not include automatic checking for this function, type random input and press Enter, then compare that the output printed on screen is identical to what you typed.
