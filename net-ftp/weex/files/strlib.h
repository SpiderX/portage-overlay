/***************************************************************************/
/*                                                                         */
/* strlib - a library for processing strings using dynamic memories        */
/* Copyright (C) 1999-2000 Yuuki NINOMIYA <gm@debian.or.jp>                */
/*                                                                         */
/* This program is free software; you can redistribute it and/or modify    */
/* it under the terms of the GNU General Public License as published by    */
/* the Free Software Foundation; either version 2, or (at your option)     */
/* any later version.                                                      */
/*                                                                         */
/* This program is distributed in the hope that it will be useful,         */
/* but WITHOUT ANY WARRANTY; without even the implied warranty of          */
/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the           */
/* GNU General Public License for more details.                            */
/*                                                                         */
/* You should have received a copy of the GNU General Public License       */
/* along with this program; if not, write to the                           */
/* Free Software Foundation, Inc., 59 Temple Place - Suite 330,            */
/* Boston, MA 02111-1307, USA.                                             */
/*                                                                         */
/***************************************************************************/

#ifndef STRLIB_H_INCLUDED
#define STRLIB_H_INCLUDED

#include <stdarg.h>
#include <stdio.h>


void *str_malloc(size_t size);
void *str_realloc(void *ptr,size_t size);
char *str_dup(const char *str);
char *str_ndup(const char *str, size_t n);
char *str_dup_printf(const char *format, ...);
char *str_concat(const char *string1, ...);
size_t printf_string_upper_bound (const char* format,va_list args);
char *str_fgets(FILE *fp);
int str_skip_fgets(FILE *fp);
char *str_tolower(char *str);

#endif /* STRLIB_H_INCLUDED */

