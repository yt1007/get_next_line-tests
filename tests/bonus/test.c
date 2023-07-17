/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   test.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: yetay <yetay@student.42kl.edu.my>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/07/07 19:21:18 by yetay             #+#    #+#             */
/*   Updated: 2023/07/17 20:09:32 by yetay            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "get_next_line_bonus.h"
#include "get_next_line-tests.h"

static int	gnl_is_diff(int i, char *f1, char *f2)
{
	int		diff;
	char	*cmd;

	cmd = "/usr/bin/diff -a";
	diff = strlen(cmd) + 1 + strlen(f1) + 1 + strlen(f2) + 1;
	cmd = " > diff_";
	diff += 1 + strlen(cmd) + 5 + 1;
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
	strcat(cmd, " > diff_");
	cmd[strlen(cmd)] = i + '0';
	strcat(cmd, ".out");
	diff = system(cmd);
	free(cmd);
	if (! diff)
	{
		unlink(f2);
		cmd = calloc(11, 1);
		strcat(cmd, "diff_");
		cmd[strlen(cmd)] = i + '0';
		strcat(cmd, ".out");
		unlink(cmd);
		free(cmd);
	}
	return (diff);
}

int	main(void)
{
	int		fd[9];
	int		ofd[9];
	int		i;
	int		diff;
	char	*gnl;
	char	*fn;
	char	*efn;

	i = 0;
	while (++i <= 3)
	{
		if (i >= 4 && i <= 5)
			continue ;
		err_putnbr(i);
		err_putstr(" ");
		fn = calloc(strlen("tests/bonus/input_") + 1 + strlen(".txt") + 1, 1);
		strcat(fn, "tests/bonus/input_");
		fn[strlen(fn)] = i + '0';
		strcat(fn, ".txt");
		fd[i - 1] = open(fn, O_RDONLY);
		free(fn);
		fn = calloc(strlen("gnl_bonus_") + 1 + strlen(".txt") + 1, 1);
		strcat(fn, "gnl_bonus_");
		fn[strlen(fn)] = i + '0';
		strcat(fn, ".txt");
		ofd[i - 1] = open(fn, O_WRONLY | O_CREAT, 0644);
		gnl = get_next_line(fd[i - 1]);
		if (gnl)
		{
			write(ofd[i - 1], gnl, strlen(gnl));
			free(gnl);
		}
		else
			write(ofd[i - 1], gnl, 0);
		close(ofd[i - 1]);
		close(fd[i - 1]);
		efn = calloc(strlen("tests/bonus/output_") + 1 + strlen(".txt") + 1, 1);
		strcat(efn, "tests/bonus/output_");
		efn[strlen(efn)] = i + '0';
		strcat(efn, ".txt");
		diff = gnl_is_diff(i, efn, fn);
		free(fn);
		free(efn);
		if (diff)
			return (1);
	}
	return (0);
}
