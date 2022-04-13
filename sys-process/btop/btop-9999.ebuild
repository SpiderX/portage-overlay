# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/aristocratos/${PN}.git"

inherit git-r3 toolchain-funcs

DESCRIPTION="A monitor of resources"
HOMEPAGE="https://github.com/aristocratos/btop"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	# respect CXXFLAGS, don't install docs
	sed -i  -e "/^OPTFLAGS/s|-O2|${CXXFLAGS}|" \
		-e "/README.md/d" Makefile \
		|| die "sed failed"
}

src_compile() {
	emake CXX="$(tc-getCXX)"
}

src_install() {
	einstalldocs
	emake DESTDIR="${D}" PREFIX="/usr" install
}
