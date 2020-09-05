/***************************************************************************/
/*                                                                         */
/* strlib - a library for processing strings using heap                    */
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

/* strlib Ver 1.0.1 */

#ifdef HAVE_CONFIG_H
#  include "config.h"
#endif  

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>
#include <ctype.h>
#include "intl.h" 
#include "strlib.h" 

#define FALSE 0
#define TRUE 1

#if !defined (G_VA_COPY)
#  if defined (__GNUC__) && defined (__PPC__) && (defined (_CALL_SYSV) || defined (_WIN32)) || defined(__s390__)
#  define G_VA_COPY(ap1, ap2)     (*(ap1) = *(ap2))
#  elif defined (G_VA_COPY_AS_ARRAY)
#  define G_VA_COPY(ap1, ap2)     g_memmove ((ap1), (ap2), sizeof (va_list))
#  elif defined (__x86_64__)
#  define G_VA_COPY(ap1, ap2)     memmove ((ap1), (ap2), sizeof (va_list))
#  else /* va_list is a pointer */
#  define G_VA_COPY(ap1, ap2)     ((ap1) = (ap2))
#  endif /* va_list is a pointer */
#endif /* !G_VA_COPY */


/* --------------------------------------------------
 NAME       str_malloc
 FUNCTION   allocate memory with checking
 INPUT      size ... allocating size
 OUTPUT     pointer to allocated memory
-------------------------------------------------- */
void *str_malloc(size_t size)
{
	void *ptr;

	ptr=malloc(size);
	if(ptr==NULL){
		fprintf(stderr,_("Cannot allocate memory.\n"));
		exit(1);
	}
	return(ptr);
}


/* --------------------------------------------------
 NAME       str_realloc
 FUNCTION   resize allocated memory with checking
 INPUT      ptr  ... pointer to allocated memory
            size ... allocating size
 OUTPUT     pointer to new allocated memory
-------------------------------------------------- */
void *str_realloc(void *ptr,size_t size)
{
	void *new_ptr;

	new_ptr=realloc(ptr,size);
	if(new_ptr==NULL){
		fprintf(stderr,_("Cannot allocate memory.\n"));
		exit(1);
	}
	return(new_ptr);
}


/* --------------------------------------------------
 NAME       str_dup
 FUNCTION   duplicate string 
 INPUT      str ... source string
 OUTPUT     pointer to duplicated string
-------------------------------------------------- */
char *str_dup(const char *str)
{
	char *ptr;

	if(str!=NULL){
		ptr=str_malloc(strlen(str)+1);
		strcpy(ptr,str);
	}else{
		ptr=NULL;
	}
	return(ptr);
}


/* --------------------------------------------------
 NAME       str_ndup
 FUNCTION   duplicate string that not more than
            n bytes are copied
 INPUT      str ... source string
 OUTPUT     pointer to duplicated string
-------------------------------------------------- */
char *str_ndup(const char *str, size_t n)
{
	char *ptr;

	if(str!=NULL){
		ptr=str_malloc(n+1);
		strncpy(ptr,str,n);
		ptr[n]='\0';
	}else{
		ptr=NULL;
	}
	return(ptr);
}


/* --------------------------------------------------
 NAME       str_concat
 FUNCTION   concatnate strings
 INPUT      strings (NULL terminated)
 OUTPUT     pointer to concatnated string
-------------------------------------------------- */
char *str_concat(const char *string1, ...)
{
	va_list ap;
	char *ptr,*temp;
	int size;

	if(string1==NULL){
		return(NULL);
	}
	va_start(ap,string1);
	size=strlen(string1)+1;
	ptr=str_malloc(size);
	strcpy(ptr,string1);

	while((temp=va_arg(ap,char *))!=NULL){
		size+=strlen(temp);
		ptr=str_realloc(ptr,size);
		strcat(ptr,temp);
	}
	va_end(ap);
	return(ptr);
}


/* --------------------------------------------------
 NAME       str_dup_printf
 FUNCTION   dupricate formated string
 INPUT      same printf
 OUTPUT     pointer to formated string
-------------------------------------------------- */
char *str_dup_printf(const char *format, ...)
{
	va_list ap1,ap2;
	char *ptr;

	va_start(ap1,format);
	G_VA_COPY(ap2,ap1);
	ptr=str_malloc(printf_string_upper_bound(format,ap1));
	vsprintf(ptr,format,ap2);
	va_end(ap2);

	return(ptr);
}


/* --------------------------------------------------
 NAME       printf_string_upper_bound
 FUNCTION   calculate upper bound of string
 INPUT      format ... printf format
            args ..... variable arguments
 OUTPUT     bytes of upper bound

 This function is from glib.
-------------------------------------------------- */
size_t printf_string_upper_bound (const char* format,va_list args)
{
  unsigned int len = 1;

  while (*format)
    {
      int long_int = FALSE;
      int extra_long = FALSE;
      char c;

      c = *format++;

      if (c == '%')
	{
	  int done = FALSE;

	  while (*format && !done)
	    {
	      switch (*format++)
		{
		  char *string_arg;

		case '*':
		  len += va_arg (args, int);
		  break;
		case '1':
		case '2':
		case '3':
		case '4':
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
		  /* add specified format length, since it might exceed the
		   * size we assume it to have.
		   */
		  format -= 1;
		  len += strtol (format, (char**) &format, 10);
		  break;
		case 'h':
		  /* ignore short int flag, since all args have at least the
		   * same size as an int
		   */
		  break;
		case 'l':
		  if (long_int)
		    extra_long = TRUE; /* linux specific */
		  else
		    long_int = TRUE;
		  break;
		case 'q':
		case 'L':
		  long_int = TRUE;
		  extra_long = TRUE;
		  break;
		case 's':
		  string_arg = va_arg (args, char *);
		  if (string_arg)
		    len += strlen (string_arg);
		  else
		    {
		      /* add enough padding to hold "(null)" identifier */
		      len += 16;
		    }
		  done = TRUE;
		  break;
		case 'd':
		case 'i':
		case 'o':
		case 'u':
		case 'x':
		case 'X':
#ifdef	G_HAVE_GINT64
		  if (extra_long)
		    (void) va_arg (args, gint64);
		  else
#endif	/* G_HAVE_GINT64 */
		    {
		      if (long_int)
			(void) va_arg (args, long);
		      else
			(void) va_arg (args, int);
		    }
		  len += extra_long ? 64 : 32;
		  done = TRUE;
		  break;
		case 'D':
		case 'O':
		case 'U':
		  (void) va_arg (args, long);
		  len += 32;
		  done = TRUE;
		  break;
		case 'e':
		case 'E':
		case 'f':
		case 'g':
#ifdef HAVE_LONG_DOUBLE
		  if (extra_long)
		    (void) va_arg (args, long double);
		  else
#endif	/* HAVE_LONG_DOUBLE */
		    (void) va_arg (args, double);
		  len += extra_long ? 64 : 32;
		  done = TRUE;
		  break;
		case 'c':
		  (void) va_arg (args, int);
		  len += 1;
		  done = TRUE;
		  break;
		case 'p':
		case 'n':
		  (void) va_arg (args, void*);
		  len += 32;
		  done = TRUE;
		  break;
		case '%':
		  len += 1;
		  done = TRUE;
		  break;
		default:
		  /* ignore unknow/invalid flags */
		  break;
		}
	    }
	}
      else
	len += 1;
    }

  return len;
}


/* --------------------------------------------------
 NAME       str_fgets
 FUNCTION   fgets with dynamic allocated memory
 INPUT      fp ... file pointer
 OUTPUT     pointer to got strings
-------------------------------------------------- */
char *str_fgets(FILE *fp)
{
	char *ptr;
	char temp[128];
	int i;

	ptr=str_malloc(1);
	*ptr='\0';
	for(i=0;;i++){
		if(fgets(temp,128,fp)==NULL){
			free(ptr);
			return(NULL);
		}
		ptr=str_realloc(ptr,127*(i+1)+1);
		strcat(ptr,temp);
		if(strchr(temp,'\n')!=NULL){
			*strchr(ptr,'\n')='\0';
			return(ptr);
		}
	}
}


/* --------------------------------------------------
 NAME       str_skip_fgets
 FUNCTION   skip a single line
 INPUT      fp ... file pointer
 OUTPUT     return 0 if successful, otherwise -1
-------------------------------------------------- */
int str_skip_fgets(FILE *fp)
{
	char temp[128];
	for(;;){
		if(fgets(temp,128,fp)==NULL){
			return(-1);
		}
		if(strchr(temp,'\n')!=NULL){
			return(0);
		}
	}
}


/* --------------------------------------------------
 NAME       str_tolower
 FUNCTION   convert string to lower case
 INPUT      str ... input string
 OUTPUT     lower string
-------------------------------------------------- */
char *str_tolower(char *str)
{
	char *temp;
	int i;

	temp=str_dup(str);
	for(i=0;i<strlen(temp);i++){
		temp[i]=tolower(temp[i]);
	}
	return(temp);
}
