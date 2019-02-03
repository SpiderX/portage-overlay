# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_PN="github.com/miguelmota/${PN}"

inherit golang-build golang-vcs-snapshot

DESCRIPTION="Interactive cryptocurrency monitor"
HOMEPAGE="https://github.com/miguelmota/cointop"
SRC_URI="https://${EGO_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

# dev-go/toml doesn't provide sources
DEPEND="dev-go/go-net:=
	dev-go/go-sys:=
	dev-go/go-text:="
RDEPEND="${DEPEND}"

src_prepare() {
	default

	# Remove bundled libs to use provided by portage
	rm -rf src/"${EGO_PN}"/vendor/golang.org || die "failed to remove golang.org"
}

src_install() {
	dobin cointop
}
