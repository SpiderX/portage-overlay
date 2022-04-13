# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/jesseduffield/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Lazier way to manage everything docker"
HOMEPAGE="https://github.com/jesseduffield/lazydocker"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
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

	GOFLAGS="-v -x -mod=vendor" \
		go build -ldflags "${LDFLAGS}" -trimpath || die "build failed"
}

src_test() {
	go test -work ./... || die "test failed"
}

src_install() {
	einstalldocs
	dobin lazydocker
}
