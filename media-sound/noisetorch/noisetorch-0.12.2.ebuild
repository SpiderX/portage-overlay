# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop edo go-module fcaps flag-o-matic toolchain-funcs

RB_COMMIT="2037560fb90dea5d2538611d983964d790bdbac2"
RN_COMMIT="1cbdbcf1283499bbb2230a6b0f126eb9b236defd"
MY_PN="NoiseTorch"

DESCRIPTION="Real-time microphone noise suppression on Linux"
HOMEPAGE="https://github.com/noisetorch/NoiseTorch"
SRC_URI="https://github.com/${PN}/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/${PN}/c-ringbuf/archive/${RB_COMMIT}.tar.gz
		-> ${P}-ringbuf-${RB_COMMIT}.tar.gz
	https://github.com/${PN}/rnnoise/archive/${RN_COMMIT}.tar.gz
		-> ${P}-rnnoise-${RB_COMMIT}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

FILECAPS=( CAP_SYS_RESOURCE=+ep usr/bin/noisetorch )

src_prepare() {
	default

	edo rmdir c/{c-ringbuf,rnnoise}
	edo ln -s ../../c-ringbuf-"${RB_COMMIT}" c/c-ringbuf
	edo ln -s ../../rnnoise-"${RN_COMMIT}" c/rnnoise

	sed -i 's/-Werror -O2 //' c/ladspa/Makefile || die "sed failed for Makefile"
}

src_compile() {
	append-cflags
	append-ldflags
	emake CC="$(tc-getCC)" -C c/ladspa

	ego generate

	LDFLAGS="-w -X main.version=${PV}"
	GOFLAGS="-v -x -mod=vendor" ego build -ldflags "${LDFLAGS}"
}

src_install() {
	einstalldocs
	dobin noisetorch
	domenu assets/noisetorch.desktop
	doicon assets/icon/noisetorch.png
	doicon -s 256 assets/icon/noisetorch.png
}
