# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/zyedidia/${PN}.git"

inherit desktop git-r3 go-module xdg

DESCRIPTION="A modern and intuitive terminal-based text editor"
HOMEPAGE="https://github.com/zyedidia/micro"
SRC_URI=""

LICENSE="Apache-2.0 BSD MIT MPL-2.0"
SLOT="0"
KEYWORDS=""
IUSE="debug"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	GOVARS="-X github.com/zyedidia/micro/v2/internal/util.Version=${PV}
		-X github.com/zyedidia/micro/v2/internal/util.CommitHash=${PV}
		-X github.com/zyedidia/micro/v2/internal/util.CompileDate=$(date +%F)
		$(usex debug '-X github.com/zyedidia/micro/v2/internal/util.Debug=ON' '' '' '')"
	go build -ldflags "-s -w -${GOVARS}" ./cmd/micro || die "build failed"
}

src_test() {
	go test -work ./internal/... || die "test failed"
}

src_install() {
	dobin micro
	doman assets/packaging/micro.1
	newicon -s scalable assets/micro-logo.svg micro.svg
	newicon assets/micro-logo.svg micro.svg
	domenu assets/packaging/micro.desktop
}
