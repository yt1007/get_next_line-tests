# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    filetypes.sh                                       :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: yetay <yetay@student.42kl.edu.my>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/07/17 12:38:54 by yetay             #+#    #+#              #
#    Updated: 2023/07/17 17:22:12 by yetay            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

MANDO="get_next_line.c get_next_line_utils.c";
BONUS=$(echo $MANDO | sed "s/\.c/_bonus&/");
TESTS="${WD}/get_next_line-tests_utils.c ${WD}/tests/files/test.c";

## Check for the mandatory and bonus files
cd ${GNL_DIR};
M=1;
for f in ${MANDO}; do
	if [[ ! -r $f ]]; then
		M=0;
	fi;
done;
if [[ ${M} -eq 0 ]]; then
	echo -ne "${RD}(mandatory files not found)${NC} ";
	exit 1;
fi;
B=1;
for f in ${BONUS}; do
	if [[ ! -r $f ]]; then 
		B=0;
	fi;
done;
if [[ ${B} -eq 0 ]]; then
	echo -n "(bonus files not found) ";
fi;

## Try to compile & run the mandatory files with buffer_size settings
## exit with 1 if either compilation failed.
cc -Wall -Wextra -Werror -I. -I${WD} -o gnl \
	${MANDO} ${TESTS};
cd ${WD} && ${GNL_DIR}/gnl;
if [[ $? -ne 0 ]]; then
	mv diff.out ${WD}/diff_$1_mando.out;
	mv gnl.out ${WD}/gnl_$1_mando.out;
	echo -ne "${RD}(Check diff_$1_mando.out)${NC} ";
	exit 1;
fi;
rm gnl.out;
rm diff.out;
cd ${GNL_DIR};
rm gnl;
## If bonus files exists, try to compile & run the bonus files with
## buffer_size settings
## Exit with 1 if either compilation failed.
if [[ ${B} == 1 ]]; then
	cc -Wall -Wextra -Werror -I. -I${WD} \
		-o gnl ${BONUS} ${TESTS};
	cd ${WD} && ${GNL_DIR}/gnl;
	if [[ $? -ne 0 ]]; then
		mv diff.out ${WD}/diff_$1_bonus.out;
		mv gnl.out ${WD}/gnl_$1_bonus.out;
		echo -n "${RD}(BONUS KO. Check diff_$1_bonus.out)${NC} ";
		exit 1;
	fi;
	rm diff.out;
	rm gnl.out;
	cd ${GNL_DIR};
fi;

exit 0;
