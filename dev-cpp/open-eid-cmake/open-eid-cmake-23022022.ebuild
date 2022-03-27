# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="eececc0"

DESCRIPTION="Open Electronic Identity CMake modules"
HOMEPAGE="https://github.com/open-eid/cmake http://id.ee"
SRC_URI="https://api.github.com/repos/open-eid/cmake/tarball/${COMMIT} -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
SLOT="0"

DOCS=( README.txt )

S="${WORKDIR}/${PN}-${COMMIT}"

src_install() {
	insinto /usr/share/cmake/open-eis
	doins -r modules
}
