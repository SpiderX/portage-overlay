# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit common-lisp-3

MY_PV="release-${PV}"

DESCRIPTION="Buildapp makes it easy to build application executables with SBCL"
HOMEPAGE="https://github.com/xach/buildapp"
SRC_URI="https://github.com/xach/${PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="runtime-options"
RESTRICT="strip"

BDEPEND="dev-lisp/asdf"

QA_FLAGS_IGNORED="/usr/bin/buildapp"

src_prepare() {
	default

	# https://github.com/sbcl/sbcl/commit/cab2298
	if use runtime-options ; then
		sed -i '/save-runtime-options/s| t| :accept-runtime-options|' buildapp.lisp \
			|| die "sed failed for buildapp.lisp"
	fi
}

src_compile() {
	emake
}

src_install() {
	common-lisp-3_src_install
	dobin buildapp
}
