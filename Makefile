# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: yetay <yetay@student.42kl.edu.my>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/07/14 11:07:26 by yetay             #+#    #+#              #
#    Updated: 2023/07/17 08:34:57 by yetay            ###   ########.fr        #
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

EXCL_TESTS = tests/large_buffer
TEST_UNITS = $(filter-out $(EXCL_TESTS), \
			              $(shell find tests -type d -mindepth 1))
TEST_SOURCES = $(addsuffix /test.c, $(TEST_UNITS))
TEST_OBJECTS = $(TEST_SOURCES:.c=.o)

UTILS_SOURCES = get_next_line-tests_utils.c
UTILS_OBJECTS = $(UTILS_SOURCES:.c=.o)

BUFFER_SIZE = 

.PHONY: mandatory mprep bonus bprep $(TEST_UNITS) $(EXCL_TESTS) \
	    all clean fclean re

mandatory: mprep $(UTILS_OBJECTS) $(TEST_UNITS) $(EXCL_TESTS)

mprep: $(MANDATORY_OBJECTS)
	@$(AR) lib$(NAME).a $^
	@echo "Running tests using MANDATORY files."

bonus: bprep $(UTILS_OBJECTS) $(TEST_UNITS) $(EXCL_TESTS)


bprep: $(BONUS_OBJECTS)
	@$(AR) lib$(NAME).a $^
	@echo "Running tests using BONUS files."

all:
	@make mandatory
	@make clean
	@make bonus

$(GNL_OBJECTS): %.o: %.c
	@$(CC) $(CFLAGS) $(INCLUDES) -c -o $@ $^

$(UTILS_OBJECTS): %.o: %.c
	@$(CC) $(CFLAGS) -c -o $@ $^

$(TEST_UNITS): %: %/test.o
	@$(CC) $(CFLAGS) -I. -o $(NAME) \
		$< $(UTILS_OBJECTS) lib$(NAME).a \
		&& ./$(NAME) && $(RM) $(NAME)

tests/large_buffer: %: %/test.o
	@$(CC) $(CFLAGS) -D 4201 -I. -o $(NAME) \
		$< $(UTILS_OBJECTS) lib$(NAME).a \
		&& ./$(NAME) && $(RM) $(NAME)

$(TEST_OBJECTS): %.o: %.c
	@$(CC) $(CFLAGS) $(INCLUDES) -I. -c -o $@ $^

clean:
	@$(RM) $(NAME)
	@$(RM) lib$(NAME).a

fclean: clean
	@$(RM) $(GNL_OBJECTS) $(UTILS_OBJECTS) $(TEST_OBJECTS)

re: fclean mandatory
