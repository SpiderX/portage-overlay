# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/open-eid/cmake.git"

inherit git-r3

DESCRIPTION="Open Electronic Identity CMake modules"
HOMEPAGE="https://github.com/open-eid/cmake http://id.ee"
SRC_URI=""

LICENSE="LGPL-2.1"
KEYWORDS=""
SLOT="0"

DOCS=( README.txt )

src_install() {
	insinto /usr/share/cmake/open-eis
	doins -r modules
}
