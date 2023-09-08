# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="OpenSSL Provider for TPM2 integration"
HOMEPAGE="https://github.com/tpm2-software/tpm2-openssl"
SRC_URI="https://github.com/tpm2-software/tpm2-openssl/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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
