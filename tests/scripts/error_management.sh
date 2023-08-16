# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    error_management.sh                                :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: yetay <yetay@student.42kl.edu.my>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/07/17 10:49:52 by yetay             #+#    #+#              #
#    Updated: 2023/08/16 08:12:01 by yetay            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

TESTS="${WD}/get_next_line-tests_utils.c ${WD}/tests/errors/test.c";

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

## Try to compile & run the mandatory files without/with buffer_size settings
## exit with 1 if either compilation failed.
if [[ ${M} -eq 1 ]]; then
	cc -Wall -Wextra -Werror -I${GNL_DIR} -I${WD} -o gnl ${MANDO} ${TESTS};
	./gnl;
	if [[ $? -ne 0 ]]; then
		echo -ne "${RD}(Failed to compile)${NC} ";
		exit 1;
	fi;
	rm gnl;
	cc -Wall -Wextra -Werror -I${GNL_DIR} -I${WD} -D BUFFER_SIZE=42 \
		-o gnl ${MANDO} ${TESTS};
	./gnl;
	if [[ $? -ne 0 ]]; then
		echo -ne "${RD}(Failed to compile with BUFFER_SIZE)${NC} ";
		exit 1;
	fi;
	rm gnl;
fi;
## If bonus files exists, try to compile & run the bonus files without/with
## buffer_size settings
## Exit with 1 if either compilation failed.
if [[ ${B} -eq 1 ]]; then
	cc -Wall -Wextra -Werror -I${GNL_DIR} -I${WD} -o gnl ${BONUS} ${TESTS};
	./gnl;
	if [[ $? -ne 0 ]]; then
		echo -ne "${RD}(BONUS KO. Failed to compile)${NC} ";
		exit 1;
	fi;
	rm gnl;
	cc -Wall -Wextra -Werror -I${GNL_DIR} -I${WD} -D BUFFER_SIZE=42 \
		-o gnl ${BONUS} ${TESTS};
	./gnl;
	if [[ $? -ne 0 ]]; then
		echo -ne "${RD}(BONUS KO. Failed to compile with BUFFER_SIZE)${NC} ";
		exit 1;
	fi;
	rm gnl;
fi;

exit 0;
