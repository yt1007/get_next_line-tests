# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    stdin.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: yetay <yetay@student.42kl.edu.my>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/07/24 17:11:57 by yetay             #+#    #+#              #
#    Updated: 2023/07/24 17:15:21 by yetay            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

TESTS="${WD}/tests/stdin/test.c";

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

## Try to compile the mandatory files without/with buffer_size settings
## exit with 1 if either compilation failed.
if [[ ${M} -eq 1 ]]; then
	cc -Wall -Wextra -Werror -I${GNL_DIR} -I${WD} -o gnl ${MANDO} ${TESTS};
	if [[ $? -ne 0 ]]; then
		echo -ne "${RD}(KO. Compilation error)${NC} "
		exit 1;
	fi;
	echo -e "get_next_line (mandatory) - Type something and press Enter.";
	./gnl;
	rm gnl;
fi;
## If bonus files exists, try to compile the bonus files without/with
## buffer_size settings
## Exit with 1 if either compilation failed.
if [[ ${B} -eq 1 ]]; then
	cc -Wall -Wextra -Werror -I${GNL_DIR} -I${WD} -o gnl ${BONUS} ${TESTS};
	if [[ $? -ne 0 ]]; then
		echo -ne "${RD}(BONUS KO. Compilation error)${NC} "
		exit 1;
	fi;
	echo -e "get_next_line (bonus) - Type something and press Enter.";
	./gnl;
	rm gnl;
fi;

exit 0;
