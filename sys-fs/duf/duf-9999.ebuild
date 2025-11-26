# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module

DESCRIPTION="Disk Usage/Free Utility"
HOMEPAGE="https://github.com/muesli/duf"
EGIT_REPO_URI="https://github.com/muesli/${PN}.git"

LICENSE="MIT"
SLOT="0"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	COMMIT="$(git rev-parse --short HEAD)"
	LDFLAGS="-X main.Version=${PV} -X main.CommitSHA=${COMMIT}"

	ego build -ldflags "${LDFLAGS}"
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin duf
	doman duf.1
}
