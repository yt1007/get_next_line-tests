/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   test.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: yetay <yetay@student.42kl.edu.my>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/07/13 18:54:08 by yetay             #+#    #+#             */
/*   Updated: 2023/07/14 12:19:47 by yetay            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <string.h>
#include "get_next_line.h"
#include "get_next_line-tests.h"

static int	run_fd_test(int fd)
{
	int		n;
	int		rd;
	void	*buffer;

	buffer = NULL;
	err_putstr("gnl-tests: FD is ");
	n = fd;
	err_putnbr(n);
	err_putstr(",\n");
	err_putstr("gnl-tests: get_next_line shouldn't be able to read this fd.");
	err_putstr("\n");
	rd = read(fd, buffer, 0);
	if (rd != -1)
	{
		err_putstr("gnl-tests: FAILED: read returns ");
		err_putnbr(rd);
		err_putstr(".\n");
		return (1);
	}
	err_putstr("gnl-tests: SUCCESS: read returns -1.\n");
	buffer = get_next_line(fd);
	if (buffer)
	{
		err_putstr("gnl-tests: FAILED: get_next_line returns \n");
		err_putstr("gnl-tests: ");
		err_putstr(buffer);
		err_putstr(".\n");
		return (1);
	}
	err_putstr("gnl-tests: SUCCESS: get_next_line returns (null).\n");
	return (0);
}

/* This test passes arbitrary file descriptor to the get_next_line function   */
/* on which it is not possible to read. The function must return NULL.        */
int	main(void)
{
	int		errors;
	int		fd;

	errors = 0;
	fd = 42;
	if (run_fd_test(fd))
		errors++;
	if (!errors)
		write(2, "All tests passed.\n", 18);
	return (0);
}
