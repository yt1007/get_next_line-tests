/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   get_next_line-tests_utils.c                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: yetay <yetay@student.42kl.edu.my>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/07/13 18:54:08 by yetay             #+#    #+#             */
/*   Updated: 2023/07/14 12:32:56 by yetay            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <string.h>
#include <unistd.h>

void	err_putstr(char *s)
{
	write(2, s, strlen(s));
}

void	err_putnbr(int n)
{
	if (n < 0)
	{
		err_putstr("-");
		if (n < -9)
			err_putnbr(-(n / 10));
		err_putnbr(-(n % 10));
	}
	else if (n > 9)
	{
		err_putnbr(n / 10);
		err_putnbr(n % 10);
	}
	else
	{
		n += '0';
		write(2, &n, 1);
	}
}
