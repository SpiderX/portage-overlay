# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/zricethezav/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Auditing git repository for secrets and keys"
HOMEPAGE="https://github.com/zricethezav/gitleaks"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	go build -ldflags "-X=github.com/zricethezav/gitleaks/v4/version.Version=${PV}" \
		|| die "build failed"
}

src_test() {
	go test -work ./... || die "test failed"
}

src_install() {
	einstalldocs
	dobin gitleaks
	dodoc -r examples/
}
