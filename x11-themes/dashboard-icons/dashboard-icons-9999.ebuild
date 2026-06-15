# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="SVG icons for popular brands"
HOMEPAGE="https://github.com/homarr-labs/dashboard-icons"
EGIT_REPO_URI="https://github.com/homarr-labs/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="png +svg webp"
REQUIRED_USE="|| ( png svg webp )"

src_install() {
	if use png ; then
		insinto /usr/share/icons/dashboard-icons
		doins -r png/.
	fi
	if use svg ; then
		insinto /usr/share/icons/dashboard-icons/scalable
		doins -r svg/.
	fi
	if use webp ; then
		insinto /usr/share/icons/dashboard-icons
		doins -r webp/.
	fi
}
