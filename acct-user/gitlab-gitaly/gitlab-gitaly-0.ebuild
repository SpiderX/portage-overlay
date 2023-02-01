# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

ACCT_USER_ID=-1
ACCT_USER_GROUPS=( gitlab )
ACCT_USER_HOME="/var/lib/gitlab-gitaly"
ACCT_USER_HOME_OWNER="gitlab-gitaly:gitlab"
ACCT_USER_HOME_PERMS=0770

acct-user_add_deps
