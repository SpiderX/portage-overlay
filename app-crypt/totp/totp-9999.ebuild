# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module

DESCRIPTION="Time-Based One-Time Password Code Generator"
HOMEPAGE="https://github.com/arcanericky/totp"
EGIT_REPO_URI="https://github.com/arcanericky/${PN}.git"

LICENSE="MIT"
SLOT="0"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	ego build -ldflags="-X github.com/arcanericky/totp/cmd.versionText=${PV} -s -w" \
		-o ./bin/"${PN}" ./cmd/totp
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin bin/totp
}
