# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="38e501f9415332d2fca53bab2b9add71fa97d8f6"

DESCRIPTION="A Common Lisp interface to OpenSSL"
HOMEPAGE="https://github.com/cl-plus-ssl/cl-plus-ssl"
SRC_URI="https://github.com/${PN}/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )" # Fail: 7

RDEPEND="dev-libs/openssl:=
	dev-lisp/alexandria
	dev-lisp/bordeaux-threads
	dev-lisp/cffi
	dev-lisp/flexi-streams
	dev-lisp/trivial-features
	dev-lisp/trivial-garbage
	dev-lisp/trivial-gray-streams
	dev-lisp/uiop
	dev-lisp/usocket"
BDEPEND="test? ( dev-lisp/fiveam
		dev-lisp/trivial-sockets )"

src_prepare() {
	default

	# disable coverage
	sed -i 's|(:feature (:or :sbcl :ccl) :cl-coveralls)||' cl+ssl.test.asd \
		|| die "sed failed for cl+ssl.test.asd"
}

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :cl+ssl)" \
		|| die "test failed"
}
