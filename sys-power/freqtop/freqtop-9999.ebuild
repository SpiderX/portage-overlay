# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/stolk/${PN}.git"

inherit git-r3 toolchain-funcs

DESCRIPTION="Monitor for the CPU Frequency Scaling under Linux"
HOMEPAGE="https://github.com/stolk/freqtop"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

src_prepare() {
	default

	sed -i "s/cc/$(tc-getCC)/" Makefile \
		die "sed failed for Makefile"
}

src_install() {
	einstalldocs
	dobin freqtop
}
