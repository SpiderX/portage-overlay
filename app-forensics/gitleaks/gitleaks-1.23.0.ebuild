# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_PN="github.com/zricethezav/${PN}"

inherit golang-build golang-vcs-snapshot

DESCRIPTION="Auditing git repository for secrets and keys"
HOMEPAGE="https://github.com/zricethezav/gitleaks"
SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

# dev-go/toml doesn't provide sources
DEPEND="dev-go/go-net:=
	dev-go/go-oauth2:=
	dev-go/go-protobuf:=
	dev-go/go-text:="
RDEPEND="${DEPEND}"

DOCS=( src/"${EGO_PN}"/README.md )

src_prepare() {
	default

	# dev-go/crypto and dev-go/sys are too old
	rm -r src/"${EGO_PN}"/vendor/golang.org/x/{net,oauth2,text} \
		src/"${EGO_PN}"/vendor/github.com/golang/protobuf \
		|| die "remove sources failed"
}

src_install() {
	einstalldocs
	dobin gitleaks
	insinto /etc/gitleaks
	doins src/"${EGO_PN}"/gitleaks.toml
}
