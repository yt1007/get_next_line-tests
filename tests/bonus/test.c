/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   test.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: yetay <yetay@student.42kl.edu.my>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/07/07 19:21:18 by yetay             #+#    #+#             */
/*   Updated: 2023/07/18 09:25:03 by yetay            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "get_next_line_bonus.h"
#include "get_next_line-tests.h"

static char	*build_fn(char *prefix, int i, char *suffix)
{
	char	*fn;

	fn = calloc(strlen(prefix) + 1 + strlen(suffix) + 1, 1);
	strcat(fn, prefix);
	fn[strlen(fn)] = i + '0';
	strcat(fn, suffix);
	return (fn);
}

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
		cmd = build_fn("diff_", i, ".out");
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
	while (++i <= 9)
	{
		fn = build_fn("tests/bonus/input_", i, ".txt");
		fd[i - 1] = open(fn, O_RDONLY);
		free(fn);
		fn = build_fn("gnl_bonus_", i, ".txt");
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
		efn = build_fn("tests/bonus/output_", i, ".txt");
		diff = gnl_is_diff(i, efn, fn);
		free(fn);
		free(efn);
		if (diff)
		{
			err_putstr("\033[0;31m");
			err_putnbr(i);
			err_putstr("\033[0m ");
			return (1);
		}
		err_putstr("\033[0;32m");
		err_putnbr(i);
		err_putstr("\033[0m ");
	}
	i = 0;
	while (++i <= 9)
		close(fd[i - 1]);
	return (0);
}
