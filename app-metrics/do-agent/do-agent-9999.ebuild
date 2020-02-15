# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/digitalocean/${PN}"
EGIT_REPO_URI="https://${EGO_PN}.git"

inherit git-r3 go-module systemd

DESCRIPTION="DigitalOcean Agent for Enhanced Droplet Graphs"
HOMEPAGE="https://github.com/digitalocean/do-agent"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="test"

src_unpack() {
	git-r3_src_unpack
}

src_compile() {
	LDFLAGS="-X main.version=${PV} -X main.revision=${PV}
		-X main.buildDate=${PV} -w -extldflags -static"

	export -n GOCACHE XDG_CACHE_HOME
	go build -ldflags "${LDFLAGS}" ./cmd/do-agent/... || die "build failed"
}

src_test() {
	go test -work ./... || die "test failed"
}

src_install() {
	dobin do-agent

	newinitd "${FILESDIR}"/do-agent.initd do-agent
	newconfd "${FILESDIR}"/do-agent.confd do-agent
	systemd_dounit "${FILESDIR}"/do-agent.service
}
