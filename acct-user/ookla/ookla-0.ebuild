# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

ACCT_USER_ID=-1
ACCT_USER_GROUPS=( ookla )
ACCT_USER_HOME="/opt/ookla"
ACCT_USER_HOME_OWNER="ookla:ookla"

acct-user_add_deps
