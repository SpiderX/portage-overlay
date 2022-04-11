# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/nektos/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Run your GitHub Actions locally"
HOMEPAGE="https://github.com/nektos/act"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="test" # needs dockerd
PROPERTIES="test_network"

RDEPEND="app-containers/docker-cli"
BDEPEND="test? ( app-containers/docker )"

DOCS=( {IMAGES,README}.md )

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	LDFLAGS="-X main.version=$${PV}"

	go build -ldflags "${LDFLAGS}" || die "build failed"
}

src_test() {
	go test -work ./... || die "test failed"
}

src_install() {
	einstalldocs
	dobin act
}
