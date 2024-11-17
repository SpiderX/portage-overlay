# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/sionescu/${PN}.git"

inherit common-lisp-3 git-r3 toolchain-funcs

DESCRIPTION="Common Lisp I/O library"
HOMEPAGE="https://github.com/sionescu/iolib"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="test" # SIMPLE-LOCAL-SOCKETS fails
PROPERTIES="test_network"

RDEPEND="dev-libs/libfixposix
	dev-lisp/alexandria
	dev-lisp/babel
	dev-lisp/bordeaux-threads
	dev-lisp/cffi
	dev-lisp/idna
	dev-lisp/split-sequence
	dev-lisp/swap-bytes
	dev-lisp/trivial-features"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/fiveam )"

src_prepare() {
	default

	# use local echo-server for tests
	sed -i '/(defparameter \*echo-address/s|iolib.cddr.org|localhost|' \
		tests/sockets.lisp || die "sed failed for sockets.lisp"
}

src_compile() {
	use test && emake -C tests CC="$(tc-getCC)"
}

src_test() {
	# can't use die here
	tests/echo-server 25877 >/dev/null 2>&1 &

	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :iolib)" \
		|| die "test failed"
}

src_install() {
	common-lisp-3_src_install
	insinto /usr/share/common-lisp/source/iolib
	doins version.sexp
}
