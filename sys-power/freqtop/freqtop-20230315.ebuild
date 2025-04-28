# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

COMMIT="bff91f1017c0f3abf2edae52498641c65fa9b0b9"

DESCRIPTION="Monitor for the CPU Frequency Scaling under Linux"
HOMEPAGE="https://github.com/stolk/freqtop"
SRC_URI="https://github.com/stolk/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_prepare() {
	default

	sed -i  -e "s/-lm/-lm \$(LDFLAGS)/" \
		-e "s/(CC)/(CC) \$(CFLAGS)/" Makefile \
		|| die "sed failed for Makefile"
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	einstalldocs
	doman freqtop.1
	dobin freqtop
}
