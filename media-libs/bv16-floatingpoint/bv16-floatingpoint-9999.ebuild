# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="BroadVoice 16 kbs codec"
HOMEPAGE="https://gitlab.linphone.org/BC/public/external/bv16-floatingpoint"
EGIT_REPO_URI="https://gitlab.linphone.org/BC/public/external/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
IUSE="static-libs"

src_configure() {
	local mycmakeargs=(
		-DENABLE_STATIC="$(usex static-libs)"
	)

	cmake_src_configure
}
