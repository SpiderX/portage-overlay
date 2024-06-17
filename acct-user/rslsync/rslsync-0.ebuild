# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

ACCT_USER_ID=116
ACCT_USER_GROUPS=( rslsync )
ACCT_USER_HOME="/var/lib/resilio-sync"
ACCT_USER_HOME_OWNER="rslsync:rslsync"

acct-user_add_deps
