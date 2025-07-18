# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3 git-r3

DESCRIPTION="A library for decompressing deflate, zlib, and gzip data"
HOMEPAGE="https://github.com/sharplispers/chipz"
EGIT_REPO_URI="https://github.com/sharplispers/${PN}.git"

LICENSE="BSD"
SLOT="0"
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
