# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-user

ACCT_USER_ID=-1
ACCT_USER_GROUPS=( swapspace )
ACCT_USER_HOME="/etc/swapspace"
ACCT_USER_HOME_OWNER="swapspace:swapspace"

acct-user_add_deps
