# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

COMMIT="a436f16b357c96b82397ec018ea469574c10dd41"

DESCRIPTION="Compatibility layer for minor MOP implementation differences"
HOMEPAGE="https://github.com/hraban/moptilities"
SRC_URI="https://github.com/hraban/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )" # 37 tests run, 7 Failures

RDEPEND="dev-lisp/closer-mop"
BDEPEND="test? ( dev-lisp/lift )"

src_prepare() {
	default

	# fix default report
	sed -i '/test-results/s|name|full-pathname|' lift-standard.config \
		|| die "sed failed for lift-standard.config"
}

src_test() {
	local -x CL_SOURCE_REGISTRY="${S}:${CLSYSTEMROOT}"
	common-lisp-export-impl-args "$(common-lisp-find-lisp-impl)"

	${CL_BINARY} "${CL_EVAL}" "(asdf:test-system :moptilities)" \
		|| die "test failed"
}
