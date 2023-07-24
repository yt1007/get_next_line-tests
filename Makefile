# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: yetay <yetay@student.42kl.edu.my>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/07/14 11:07:26 by yetay             #+#    #+#              #
#    Updated: 2023/07/24 16:35:21 by yetay            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

RM = rm -rf


NAME = gnl
OUTFILES = norminette.out

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
