# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    filetypes.sh                                       :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: yetay <yetay@student.42kl.edu.my>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/07/17 12:38:54 by yetay             #+#    #+#              #
#    Updated: 2023/07/24 16:53:56 by yetay            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

TESTS="${WD}/get_next_line-tests_utils.c ${WD}/tests/files/test.c";

## Check for the mandatory and bonus files
cd ${GNL_DIR};
if [[ ${M} -eq 1 ]]; then
	for f in ${MANDO}; do
		if [[ ! -r $f ]]; then
			echo -ne "${RD}cannot read ${f}${NC} ";
			M=0;
		fi;
	done;
	if [[ ${M} -eq 0 ]]; then
		exit 1;
	fi;
fi;
if [[ ${B} -eq 1 ]]; then
	for f in ${BONUS}; do
		if [[ ! -r $f ]]; then 
			echo -ne "${RD}cannot read ${f}${NC} ";
			B=0;
		fi;
	done;
	if [[ ${B} -eq 0 ]]; then
		exit 1;
	fi;
fi;

## Try to compile & run the mandatory files with buffer_size settings
## exit with 1 if either compilation failed.
if [[ ${M} -eq 1 ]]; then
	cc -Wall -Wextra -Werror -I${GNL_DIR} -I${WD} -o gnl \
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
fi;
## If bonus files exists, try to compile & run the bonus files with
## buffer_size settings
## Exit with 1 if either compilation failed.
if [[ ${B} -eq 1 ]]; then
	cc -Wall -Wextra -Werror -I${GNL_DIR} -I${WD} \
		-o gnl ${BONUS} ${TESTS};
	cd ${WD} && ${GNL_DIR}/gnl;
	if [[ $? -ne 0 ]]; then
		mv diff.out ${WD}/diff_$1_bonus.out;
		mv gnl.out ${WD}/gnl_$1_bonus.out;
		echo -ne "${RD}(BONUS KO. Check diff_$1_bonus.out)${NC} ";
		exit 1;
	fi;
	rm diff.out;
	rm gnl.out;
	cd ${GNL_DIR};
	rm gnl;
fi;

exit 0;
