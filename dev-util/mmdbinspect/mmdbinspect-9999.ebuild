# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module

DESCRIPTION="Look up records for one or more IPs/networks in one or more .mmdb databases"
HOMEPAGE="https://github.com/maxmind/mmdbinspect"
EGIT_REPO_URI="https://github.com/maxmind/${PN}.git"

LICENSE="Apache-2.0 MIT"
SLOT="0"

DOCS=( {CHANGELOG,README}.md )

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	ego build ./cmd/mmdbinspect/...
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin mmdbinspect
}
