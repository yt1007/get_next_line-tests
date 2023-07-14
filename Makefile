# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: yetay <yetay@student.42kl.edu.my>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/07/14 11:07:26 by yetay             #+#    #+#              #
#    Updated: 2023/07/14 13:07:08 by yetay            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

CC = cc
CFLAGS = -Wall -Werror -Wextra
AR = ar rs
RM = rm -rf

NAME = gnl
GNL_DIR = ../get_next_line

INCLUDES = $(addprefix -I, $(GNL_DIR))

GNL_FNS = get_next_line.c \
		  get_next_line_utils.c
MANDATORY_SOURCES = $(addprefix $(GNL_DIR)/, $(GNL_FNS))
MANDATORY_OBJECTS = $(MANDATORY_SOURCES:.c=.o)

BONUS_SOURCES = $(addprefix $(GNL_DIR)/, $(GNL_FNS:.c=_bonus.c))
BONUS_OBJECTS = $(BONUS_SOURCES:.c=.o)

GNL_OBJECTS = $(MANDATORY_OBJECTS) $(BONUS_OBJECTS)

TEST_UNITS = $(shell find tests -type d -mindepth 1)
TEST_SOURCES = $(addsuffix /test.c, $(TEST_UNITS))
TEST_OBJECTS = $(TEST_SOURCES:.c=.o)

UTILS_SOURCES = get_next_line-tests_utils.c
UTILS_OBJECTS = $(UTILS_SOURCES:.c=.o)

.PHONY: mandatory mprep bonus bprep $(TEST_UNITS) all clean fclean re

mandatory: mprep $(UTILS_OBJECTS) $(TEST_UNITS)

mprep: $(MANDATORY_OBJECTS)
	@$(AR) lib$(NAME).a $^

bonus: bprep $(UTILS_OBJECTS) $(TEST_UNITS)

bprep: $(BONUS_OBJECTS)
	@$(AR) lib$(NAME).a $^

all: mandatory bonus

$(GNL_OBJECTS): %.o: %.c
	@$(CC) $(CFLAGS) $(INCLUDES) -c -o $@ $^

$(UTILS_OBJECTS): %.o: %.c
	@$(CC) $(CFLAGS) -c -o $@ $^

$(TEST_UNITS): %: %/test.o
	@$(CC) $(CFLAGS) -I. -o $(NAME) \
		$< $(UTILS_OBJECTS) lib$(NAME).a \
		&& ./gnl && $(RM) gnl

$(TEST_OBJECTS): %.o: %.c
	@$(CC) $(CFLAGS) $(INCLUDES) -I. -c -o $@ $^

clean:
	@$(RM) $(NAME)

fclean: clean
	@$(RM) $(ALL_OBJECTS)

re: fclean mandatory
