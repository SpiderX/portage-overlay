# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/fossas/${PN}"
EGIT_REPO_URI="https://github.com/fossas/${PN}.git"
EGIT_CHECKOUT_DIR="${WORKDIR}/${P}/src/${EGO_PN}"

inherit git-r3 golang-build

DESCRIPTION="License and vulnerability analysis"
HOMEPAGE="https://github.com/fossas/fossa-cli"
SRC_URI=""

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""

src_compile() {
	# EGO_BUILD_FLAGS='-ldflags "...."' doesn't work
	LDFLAGS="-extldflags '-static' -X github.com/fossas/fossa-cli/cmd/fossa/version.version=${PV}"
	GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath)" go build -v -work -x -ldflags="${LDFLAGS}" \
		-o fossa "${EGO_PN}"/cmd/fossa || die
}

src_install() {
	dobin fossa
}
