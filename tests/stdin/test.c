/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   test.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: yetay <yetay@student.42kl.edu.my>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/07/24 13:00:02 by yetay             #+#    #+#             */
/*   Updated: 2023/07/24 17:16:23 by yetay            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <string.h>
#include "get_next_line.h"

int	main(void)
{
	char	*gnl;

	gnl = get_next_line(0);
	if (gnl)
		write(1, gnl, strlen(gnl));
	else
		write(1, gnl, 0);
	free(gnl);
	return (0);
}
