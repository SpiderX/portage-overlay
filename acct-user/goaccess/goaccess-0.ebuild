# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

ACCT_USER_ID=523
ACCT_USER_GROUPS=( goaccess )
ACCT_USER_HOME="/var/lib/goaccess"
ACCT_USER_HOME_OWNER="goaccess:goaccess"
ACCT_USER_HOME_PERMS=0770

acct-user_add_deps
