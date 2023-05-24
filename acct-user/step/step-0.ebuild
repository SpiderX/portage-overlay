# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

ACCT_USER_ID=-1
ACCT_USER_GROUPS=( step )
ACCT_USER_HOME="/etc/step"
ACCT_USER_HOME_OWNER="step:step"

acct-user_add_deps
