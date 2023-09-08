# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/tpm2-software/${PN}.git"

inherit autotools git-r3

DESCRIPTION="OpenSSL Provider for TPM2 integration"
HOMEPAGE="https://github.com/tpm2-software/tpm2-openssl"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="app-crypt/tpm2-tss:=
	>=dev-libs/openssl-3:0="
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig
	test? ( app-crypt/swtpm
		app-crypt/tpm2-abrmd
		app-crypt/tpm2-tools )"
RESTRICT="test"

DOCS=( docs/CHANGELOG.md README.md )

src_prepare() {
	default

	eautoreconf
}

src_test() {
	make check
}

src_install() {
	default

	find "${ED}" -type f -name "*.la" -delete || die "find failed"
}
