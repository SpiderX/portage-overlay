# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/jesseduffield/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Lazier way to manage everything docker"
HOMEPAGE="https://github.com/jesseduffield/lazydocker"

LICENSE="MIT"
SLOT="0"
RESTRICT="test"
PROPERTIES="test_network"

src_unpack() {
	git-r3_src_unpack
}

src_compile() {
	DATE="$(date -u '+%Y-%m-%d-%H%M UTC')"
	COMMIT="$(git rev-parse --short HEAD)"
	LDFLAGS="-s -w -X main.version=${PV} -X \"main.date=${DATE}\"
		-X main.buildSource=git -X main.commit=${COMMIT}"

	GOFLAGS="-v -x -mod=vendor" ego build -ldflags "${LDFLAGS}"
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin lazydocker
}
