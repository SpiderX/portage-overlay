# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3 flag-o-matic

DESCRIPTION="Implementation of C++20's std::span for older compilers"
HOMEPAGE="https://github.com/tcbrindle/span"
EGIT_REPO_URI="https://github.com/serge-sans-paille/${PN}.git"

LICENSE="BSD-1"
SLOT="0"

# https://github.com/tcbrindle/span/pull/53
PATCHES=( "${FILESDIR}/${PN}"-20220615-exceptions.patch )

src_configure() {
	append-cppflags -DCATCH_CONFIG_NO_POSIX_SIGNALS
	cmake_src_configure
}

src_install() {
	doheader -r include/.
}
