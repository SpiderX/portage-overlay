# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

COMMIT="be05115"

DESCRIPTION="Lazier way to manage everything docker"
HOMEPAGE="https://github.com/jesseduffield/lazydocker"
SRC_URI="https://github.com/jesseduffield/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"
PROPERTIES="test_network"

src_compile() {
	DATE="$(date -u '+%Y-%m-%d-%H%M UTC')"
	LDFLAGS="-s -w -X main.version=${PV} -X \"main.date=${DATE}\"
		-X main.buildSource=tarball -X main.commit=${COMMIT}"

	GOFLAGS="-v -x -mod=vendor" ego build -ldflags "${LDFLAGS}"
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin lazydocker
}
