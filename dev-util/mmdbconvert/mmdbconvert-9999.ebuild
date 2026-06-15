# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module

DESCRIPTION="A command-line tool to merge multiple MaxMind MMDB databases"
HOMEPAGE="https://github.com/maxmind/mmdbconvert"
EGIT_REPO_URI="https://github.com/maxmind/${PN}.git"

LICENSE="Apache-2.0 MIT"
SLOT="0"

BDEPEND=">=dev-lang/go-1.25.3"

DOCS=( {CHANGELOG,README}.md )

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	LDFLAGS="-w -X main.version=${PV}"

	ego build -ldflags "${LDFLAGS}" ./cmd/mmdbconvert/...
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin mmdbconvert
}
