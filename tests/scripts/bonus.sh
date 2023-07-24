# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    bonus.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: yetay <yetay@student.42kl.edu.my>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/07/17 12:38:54 by yetay             #+#    #+#              #
#    Updated: 2023/07/18 08:56:52 by yetay            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

TESTS="${WD}/get_next_line-tests_utils.c ${WD}/tests/bonus/test.c";

## Check for the mandatory and bonus files
cd ${GNL_DIR};
B=1;
for f in ${BONUS}; do
	if [[ ! -r $f ]]; then 
		B=0;
	fi;
done;
if [[ ${B} -eq 0 ]]; then
	echo -ne "${RD}(BONUS MISSING)${NC} ";
fi;

## If bonus files exists, try to compile & run the bonus files with
## buffer_size settings
## Exit with 1 if either compilation failed.
if [[ ${B} == 1 ]]; then
	cc -Wall -Wextra -Werror -I${GNL_DIR} -I${WD} \
		-o gnl ${BONUS} ${TESTS};
	cd ${WD} && ${GNL_DIR}/gnl;
	if [[ $? -ne 0 ]]; then
		echo -ne "${RD}(BONUS KO. Check diff.out files)${NC} ";
		exit 1;
	fi;
	cd ${GNL_DIR};
	rm gnl;
fi;

exit 0;
