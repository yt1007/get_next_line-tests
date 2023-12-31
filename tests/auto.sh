# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    auto.sh                                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: yetay <yetay@student.42kl.edu.my>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/07/17 10:24:44 by yetay             #+#    #+#              #
#    Updated: 2023/07/24 17:17:32 by yetay            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

GNL_DIR=../get_next_line

## export the paths
export WD=$(pwd);
cd ${GNL_DIR};
export GNL_DIR=$(pwd);
cd ${WD};

## export the colours
export RD='\033[0;31m';
export GR='\033[0;32m';
export BL='\033[1;34m';
export NC='\033[0m';

## export the MANDATORY and BONUS FILE NAMES
export MANDO="get_next_line.c get_next_line_utils.c";
export BONUS=$(echo $MANDO | sed "s/\.c/_bonus&/g");

## export the M and B variable (M = run mandatory, B = run bonus)
if [[ "$1" == "m" ]]; then
	M=1;
	B=0;
elif [[ "$1" == "b" ]]; then
	M=0;
	B=1;
else
	M=1;
	B=1;
fi;
export M;
export B;

## Norminette
echo -ne "${BL}Running norminette on *.h and *.c files${NC}... "
bash tests/scripts/norminette.sh;
if [[ $? -eq 0 ]]; then
	echo -e "${GR}OK${NC}.";
else
	echo -e "${RD}KO.${NC}";
fi;

## Compilation
echo -ne "${BL}Running compilation tests${NC}... "
bash tests/scripts/compilation.sh;
if [[ $? -eq 0 ]]; then
	echo -e "${GR}OK${NC}.";
else
	echo -e "${RD}KO.${NC}";
fi;

## Error management
echo -ne "${BL}Running error management tests${NC}... ";
bash tests/scripts/error_management.sh;
if [[ $? -eq 0 ]]; then
	echo -e "${GR}OK${NC}.";
else
	echo -e "${RD}KO.${NC}";
fi;

## Testing
# FILES WITH NEW LINE
echo -ne "${BL}Running tests with file containing newline${NC}... ";
ln tests/files/input_fwnl.txt input.txt;
ln tests/files/output_fwnl.txt output_expected.txt;
bash tests/scripts/filetypes.sh fwnl;
if [[ $? -eq 0 ]]; then
	echo -e "${GR}OK${NC}.";
else
	echo -e "${RD}KO.${NC}";
fi;
rm input.txt;
rm output_expected.txt;
# FILES WIHTHOUT NEW LINE
echo -ne "${BL}Running tests with file without a newline${NC}... ";
ln tests/files/input_fnnl.txt input.txt;
ln tests/files/output_fnnl.txt output_expected.txt;
bash tests/scripts/filetypes.sh fnnl;
if [[ $? -eq 0 ]]; then
	echo -e "${GR}OK${NC}.";
else
	echo -e "${RD}KO.${NC}";
fi;
rm input.txt;
rm output_expected.txt;
# EMPTY FILE
echo -ne "${BL}Running tests with empty file${NC}... ";
ln tests/files/input_empty.txt input.txt;
ln tests/files/output_empty.txt output_expected.txt;
bash tests/scripts/filetypes.sh empty;
if [[ $? -eq 0 ]]; then
	echo -e "${GR}OK${NC}.";
else
	echo -e "${RD}KO.${NC}";
fi;
rm input.txt;
rm output_expected.txt;
echo -e "${BL}Running test where get_next_line is supposed to read from stdin${NC}... ";
echo -e "(There is no automatic detection for this test. You should compare that the output is the same as your input up until you press Enter)";
bash tests/scripts/stdin.sh;

# LARGE BUFFER SIZE
echo -ne "${BL}Running tests with BUFFER_SIZE = 4201${NC}... ";
bash tests/scripts/buffer.sh 4201;
if [[ $? -eq 0 ]]; then
	echo -e "${GR}OK${NC}.";
else
	mv diff.out buffer_4201_diff.out;
	echo -e "${RD}KO.${NC}";
fi;
rm gnl.out;
# SMALL BUFFER SIZE
echo -ne "${BL}Running tests with BUFFER_SIZE = 7${NC}... ";
bash tests/scripts/buffer.sh 7;
if [[ $? -eq 0 ]]; then
	echo -e "${GR}OK${NC}.";
else
	mv diff.out buffer_7_diff.out;
	echo -e "${RD}KO.${NC}";
fi;
rm gnl.out;
echo -ne "${BL}Running tests with BUFFER_SIZE = 1${NC}... ";
bash tests/scripts/buffer.sh 1;
if [[ $? -eq 0 ]]; then
	echo -e "${GR}OK${NC}.";
else
	mv diff.out buffer_1_diff.out;
	echo -e "${RD}KO.${NC}";
fi;
rm gnl.out;
# BUFFER SIZE = LENGTH OF LINE
LINE=$(head -n 1 tests/buffer/input.txt | wc -c | sed "s/^ *//");
echo -ne "${BL}Running tests with BUFFER_SIZE = ${LINE} (length of input line)${NC}... ";
bash tests/scripts/buffer.sh ${LINE};
if [[ $? -eq 0 ]]; then
	echo -e "${GR}OK${NC}.";
else
	mv diff.out buffer_${LINE}_diff.out;
	echo -e "${RD}KO.${NC}";
fi;
rm gnl.out;
# BUFFER SIZE = LENGTH OF LINE +/- 1
echo -ne "${BL}Running tests with BUFFER_SIZE = $[${LINE} - 1] (length of input line - 1)${NC}... ";
bash tests/scripts/buffer.sh $[${LINE} - 1];
if [[ $? -eq 0 ]]; then
	echo -e "${GR}OK${NC}.";
else
	mv diff.out buffer_$[${LINE} - 1]_diff.out;
	echo -e "${RD}KO.${NC}";
fi;
rm gnl.out;
echo -ne "${BL}Running tests with BUFFER_SIZE = $[${LINE} + 1] (length of input line + 1)${NC}... ";
bash tests/scripts/buffer.sh $[${LINE} + 1];
if [[ $? -eq 0 ]]; then
	echo -e "${GR}OK${NC}.";
else
	mv diff.out buffer_$[${LINE} + 1]_diff.out;
	echo -e "${RD}KO.${NC}";
fi;
rm gnl.out;
# SINGLE/MULTI LONG/SHORT/EMPTY LINE(S)
for n in single multi; do
	for x in long short empty; do
		echo -ne "${BL}Running test with a file containing ${n} ${x} line";
		if [[ ${n} == "multi" ]]; then
			echo -ne "s";
		fi;
		echo -ne "${NC}... ";
		ln tests/sm_lse/input_${n}_${x}.txt input.txt;
		ln tests/sm_lse/output_${n}_${x}.txt output_expected.txt;
		bash tests/scripts/filetypes.sh ${n}_${x};
		if [[ $? -eq 0 ]]; then
			echo -e "${GR}OK${NC}.";
		else
			echo -e "${RD}KO.${NC}";
		fi;
		rm input.txt;
		rm output_expected.txt;
	done;
done;

## BONUS
if [[ ${B} -eq 1 ]]; then
	# MULTIPLE FD
	echo -ne "${BL}Running tests with multiple file descriptors${NC}... ";
	bash tests/scripts/bonus.sh;
	if [[ $? -eq 0 ]]; then
		echo -e "${GR}OK${NC}.";
	else
		echo -e "${RD}KO.${NC}";
	fi;
	# Single static variable
	cd ${GNL_DIR};
	echo -ne "${BL}Checking if bonus files for static variables${NC}... ";
	sc=$(grep -hw "static" *_bonus.[ch] | grep -v "^\/\*" | grep -cv "[()]");
	if [[ ${sc} -eq 1 ]]; then
		echo -e "${GR}OK${NC}.";
	else
		echo -e "${RD}KO.${NC}";
		echo -e "Automatically detected static variable: ${RD}${sc}${NC}";
	fi;
fi;
