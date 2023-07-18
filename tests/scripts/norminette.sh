# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    norminette.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: yetay <yetay@student.42kl.edu.my>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/07/17 11:41:24 by yetay             #+#    #+#              #
#    Updated: 2023/07/18 08:57:29 by yetay            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

OUTPUT=norminette.out;

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

## Check norminette for all files
cd ${GNL_DIR};
norminette -R CheckDefine *h > ${OUTPUT};
norminette -R CheckForbiddenSourceHeader *c >> ${OUTPUT};
if [[ $(grep -cv "OK\!$" ${OUTPUT}) -eq 0 ]]; then
	rm ${OUTPUT};
else
	mv ${OUTPUT} ${WD};
	echo -ne "${RD}(Check norminette.out.)${NC} ";
	exit 1;
fi;
exit 0;
