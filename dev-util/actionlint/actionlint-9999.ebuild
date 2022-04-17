# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/rhysd/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Static checker for GitHub Actions workflow files"
HOMEPAGE="https://github.com/rhysd/actionlint"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="doc"
RESTRICT="test"
PROPERTIES="test_network"

BDEPEND="doc? ( app-text/ronn )"

DOCS=( {CHANGELOG,README}.md docs/{checks,config,usage}.md )

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	LDFLAGS="-s -w -X github.com/rhysd/actionlint.version=${PV}"

	go build -ldflags "${LDFLAGS}" ./cmd/actionlint || die "build failed"

	use doc && emake man
}

src_install() {
	einstalldocs
	dobin actionlint
	use doc && doman man/actionlint.1
}
