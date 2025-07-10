# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="6f803684415704114f213c64e13b231627e7777f"

DESCRIPTION="A library for decompressing deflate, zlib, and gzip data"
HOMEPAGE="https://github.com/sharplispers/chipz"
SRC_URI="https://github.com/sharplispers/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( dev-lisp/sbcl:*
		dev-lisp/salza2 )"

PATCHES=( "${FILESDIR}/${PN}"-20230418-fix-asd.patch )

src_test() {
	einfo "Running test suite:"
	AUTOPKGTEST_TMP="${T}" sbcl --script "${FILESDIR}"/run-tests.lisp \
		|| die "test failed"
}
