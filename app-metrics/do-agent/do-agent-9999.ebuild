# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# can't use golang-vcs due repository in EGO_PN
EGO_PN="github.com/digitalocean/${PN}"
EGIT_REPO_URI="https://${EGO_PN}.git"
EGIT_CHECKOUT_DIR="${WORKDIR}/${P}/src/${EGO_PN}"

inherit git-r3 golang-base systemd

DESCRIPTION="DigitalOcean Agent for Enhanced Droplet Graphs"
HOMEPAGE="https://github.com/digitalocean/do-agent"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="!test? ( test )"

src_compile() {
	LDFLAGS="-X main.version=${PV} -X main.revision=${PV}
		-X main.buildDate=${PV} -w -extldflags -static"

	pushd src/"${EGO_PN}" || die "pushd failed"
	GOPATH="${S}:$(get_golibdir_gopath)" go build -v -ldflags "${LDFLAGS}" \
		-o do-agent ./cmd/do-agent || die "go build failed"
	popd || die "popd failed"
}

src_test() {
	GOPATH="${S}:$(get_golibdir_gopath)" go test -v ./... \
		|| die "tests failed"
}

src_install() {
	dobin src/"${EGO_PN}"/do-agent

	newinitd "${FILESDIR}"/do-agent.initd do-agent
	newconfd "${FILESDIR}"/do-agent.confd do-agent
	systemd_dounit "${FILESDIR}"/do-agent.service
}
