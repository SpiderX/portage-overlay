# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="Simple, portable tool for measuring SMTP server delay"
HOMEPAGE="https://github.com/halon/smtpping"
EGIT_REPO_URI="https://github.com/halon/${PN}.git"

LICENSE="GPL-2"
SLOT="0"

src_configure() {
	local mycmakeargs=(
		-DMAN_INSTALL_DIR="/usr/share/man"
	)
	cmake_src_configure
}
