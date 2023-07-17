/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   test.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: yetay <yetay@student.42kl.edu.my>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/07/07 19:21:18 by yetay             #+#    #+#             */
/*   Updated: 2023/07/17 08:10:13 by yetay            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include "get_next_line.h"
#include "get_next_line-tests.h"

static int	gnl_is_diff(char *f1, char *f2)
{
	int		diff;
	char	*cmd;

	cmd = "/usr/bin/diff -a";
	diff = strlen(cmd) + 1 + strlen(f1) + 1 + strlen(f2) + 1;
	cmd = " > diff.out";
	diff += 1 + strlen(cmd) + 1;
	cmd = calloc(diff, 1);
	if (!cmd)
	{
		err_putstr("[Allocation failed]");
		return (0);
	}
	strcat(cmd, "/usr/bin/diff -a ");
	strcat(cmd, f1);
	strcat(cmd, " ");
	strcat(cmd, f2);
	strcat(cmd, " > diff.out");
	diff = system(cmd);
	free(cmd);
	return (diff);
}

int	main(void)
{
	int		fd;
	int		ofd;
	char	*gnl;

	err_putstr("Running large buffer size tests... ");
	fd = open("tests/large_buffer/input.txt", O_RDONLY);
	ofd = open("gnl.out", O_WRONLY | O_CREAT, 0644);
	gnl = get_next_line(fd);
	if (gnl)
		write(ofd, gnl, strlen(gnl));
	else
		write(ofd, "(null)", 6);
	free(gnl);
	close(ofd);
	close(fd);
	if (gnl_is_diff("gnl.out", "tests/large_buffer/output_expected.txt"))
		err_putstr("test failed.\n");
	else
	{
		err_putstr("All tests passed.\n");
		system("cat diff.out");
		unlink("diff.out");
	}
	unlink("gnl.out");
	return (0);
}
