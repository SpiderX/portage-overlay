# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop git-r3 go-module fcaps flag-o-matic toolchain-funcs

DESCRIPTION="Real-time microphone noise suppression on Linux"
HOMEPAGE="https://github.com/noisetorch/NoiseTorch"
EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"

LICENSE="GPL-3"
SLOT="0"

FILECAPS=( CAP_SYS_RESOURCE=+ep usr/bin/noisetorch )

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	default

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
