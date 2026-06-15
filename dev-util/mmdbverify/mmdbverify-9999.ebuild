# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module

DESCRIPTION="Verifier for the MaxMind DB format"
HOMEPAGE="https://github.com/maxmind/mmdbverify"
EGIT_REPO_URI="https://github.com/maxmind/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"

DOCS=( {CHANGELOG,README}.md )

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	ego build
}

src_install() {
	einstalldocs
	dobin mmdbverify
}
