# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    compilation.sh                                     :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: yetay <yetay@student.42kl.edu.my>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/07/17 10:49:52 by yetay             #+#    #+#              #
#    Updated: 2023/07/17 11:29:46 by yetay            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

MANDO="get_next_line.c get_next_line_utils.c";
BONUS=$(echo $MANDO | sed "s/\.c/_bonus&/");
TESTS="${WD}/get_next_line-tests_utils.c ${WD}/tests/errors/test.c";

## Check for the mandatory and bonus files
cd ${GNL_DIR};
M=1;
for f in ${MANDO}; do
	if [[ ! -r $f ]]; then
		M=0;
	fi;
done;
if [[ ${M} -eq 0 ]]; then
	echo -n "(mandatory files not found) ";
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

## Try to compile the mandatory files without/with buffer_size settings
## exit with 1 if either compilation failed.
cc -Wall -Wextra -Werror -I. -I${WD} -o gnl ${MANDO} ${TESTS};
if [[ $? -ne 0 ]]; then
	exit 1;
fi;
rm gnl;
cc -Wall -Wextra -Werror -I. -I${WD} -D BUFFER_SIZE=42 \
	-o gnl ${MANDO} ${TESTS};
if [[ $? -ne 0 ]]; then
	exit 1;
fi;
rm gnl;
## If bonus files exists, try to compile the bonus files without/with
## buffer_size settings
## Exit with 1 if either compilation failed.
if [[ ${B} == 1 ]]; then
	cc -Wall -Wextra -Werror -I. -I${WD} -o gnl ${BONUS} ${TESTS};
	if [[ $? -ne 0 ]]; then
		exit 1;
	fi;
	rm gnl;
	cc -Wall -Wextra -Werror -I. -I${WD} -D BUFFER_SIZE=42 \
		-o gnl ${BONUS} ${TESTS};
	if [[ $? -ne 0 ]]; then
		exit 1;
	fi;
	rm gnl
fi;

exit 0;
