# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

TMPFILES_OPTIONAL=1

inherit acct-user tmpfiles

ACCT_USER_ID=-1
ACCT_USER_GROUPS=( amazon )
ACCT_USER_HOME="/opt/aws"
ACCT_USER_HOME_OWNER="amazon:amazon"

acct-user_add_deps

src_install() {
	acct-user_src_install

	keepdir /etc/amazon /var/log/amazon
	newtmpfiles "${FILESDIR}"/amazon.tmpfile amazon.conf
}

pkg_postinst() {
	tmpfiles_process amazon.conf
}
