# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop go-module xdg

COMMIT="04c5770"

DESCRIPTION="A modern and intuitive terminal-based text editor"
HOMEPAGE="https://github.com/zyedidia/micro"
SRC_URI="https://github.com/zyedidia/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="Apache-2.0 BSD MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

src_compile() {
	GOVARS="-X github.com/zyedidia/micro/v2/internal/util.Version=${PV}
		-X github.com/zyedidia/micro/v2/internal/util.CommitHash=${COMMIT}
		-X github.com/zyedidia/micro/v2/internal/util.CompileDate=$(date +%F)
		$(usex debug '-X github.com/zyedidia/micro/v2/internal/util.Debug=ON' '' '' '')"
	ego build -ldflags "-w -${GOVARS}" ./cmd/micro
}

src_test() {
	ego test -work ./cmd/... ./internal/...
}

src_install() {
	dobin micro
	doman assets/packaging/micro.1
	newicon -s scalable assets/micro-logo.svg micro.svg
	newicon assets/micro-logo.svg micro.svg
	domenu assets/packaging/micro.desktop
}
