# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: yetay <yetay@student.42kl.edu.my>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/07/14 11:07:26 by yetay             #+#    #+#              #
#    Updated: 2023/07/24 17:19:33 by yetay            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

RM = rm -rf


NAME = gnl
OUTFILES = norminette.out \
		   input.txt output_expected.txt \
		   buffer_*_diff.out \
		   diff_*.out gnl_*.out \

.PHONY: mandatory bonus all \
	    clean fclean re

mandatory:
	@echo "Running tests using mandatory files...";
	@bash tests/auto.sh m

bonus:
	@echo "Running tests using bonus files...";
	@bash tests/auto.sh b

all:
	@echo "Running all tests...";
	@bash tests/auto.sh

clean:
	@$(RM) $(NAME)
	@$(RM) $(OUTFILES)

fclean: clean

re: fclean mandatory
