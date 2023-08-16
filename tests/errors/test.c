/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   test.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: yetay <yetay@student.42kl.edu.my>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/07/13 18:54:08 by yetay             #+#    #+#             */
/*   Updated: 2023/08/16 08:13:09 by yetay            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <limits.h>
#include "get_next_line.h"
#include "get_next_line-tests.h"

static int	run_fd_test(int fd)
{
	void	*buffer;

	buffer = NULL;
	buffer = get_next_line(fd);
	if (buffer)
	{
		err_putstr("\033[0;31m");
		err_putnbr(fd);
		err_putstr("\033[0m ");
		free(buffer);
		return (1);
	}
	err_putstr("\033[0;32m");
	err_putnbr(fd);
	err_putstr("\033[0m ");
	return (0);
}

/* This test passes arbitrary file descriptor to the get_next_line function   */
/* on which it is not possible to read. The function must return NULL.        */
int	main(void)
{
	int		errors;

	errors = 0;
	if (OPEN_MAX > -1 && run_fd_test(-1))
		errors++;
	if (OPEN_MAX > 42 && run_fd_test(42))
		errors++;
	if (OPEN_MAX > 1024 && run_fd_test(1024))
		errors++;
	if (OPEN_MAX > 4096 && run_fd_test(4096))
		errors++;
	if (OPEN_MAX > 124816 && run_fd_test(124816))
		errors++;
	if (errors)
		return (1);
	return (0);
}
