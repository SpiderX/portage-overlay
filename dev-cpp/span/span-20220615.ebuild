# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

COMMIT="836dc6a0efd9849cb194e88e4aa2387436bb079b"

DESCRIPTION="Implementation of C++20's std::span for older compilers"
HOMEPAGE="https://github.com/tcbrindle/span"
SRC_URI="https://github.com/tcbrindle/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="BSD-1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# https://github.com/tcbrindle/span/pull/53
PATCHES=( "${FILESDIR}/${PN}"-20220615-exceptions.patch )

src_configure() {
	append-cppflags -DCATCH_CONFIG_NO_POSIX_SIGNALS
	cmake_src_configure
}

src_install() {
	doheader -r include/.
}
