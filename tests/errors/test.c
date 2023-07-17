/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   test.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: yetay <yetay@student.42kl.edu.my>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/07/13 18:54:08 by yetay             #+#    #+#             */
/*   Updated: 2023/07/17 11:39:50 by yetay            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "get_next_line.h"
#include "get_next_line-tests.h"

static int	run_fd_test(int fd)
{
	int		n;
	int		rd;
	void	*buffer;

	buffer = NULL;
	n = fd;
	rd = read(fd, buffer, 0);
	if (rd != -1)
		return (1);
	buffer = get_next_line(fd);
	if (buffer)
		return (1);
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
	if (errors)
		return (1);
	return (0);
}
