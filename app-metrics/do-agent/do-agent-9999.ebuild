# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module systemd

DESCRIPTION="DigitalOcean Agent for Enhanced Droplet Graphs"
HOMEPAGE="https://github.com/digitalocean/do-agent"
EGIT_REPO_URI="https://github.com/digitalocean/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"

src_unpack() {
	git-r3_src_unpack
}

src_compile() {
	LDFLAGS="-X main.version=${PV} -X main.revision=${PV}
		-X main.buildDate=${PV} -w -extldflags -static"
	GOFLAGS="-v -x -mod=vendor" \
		go build -ldflags "${LDFLAGS}" ./cmd/do-agent/... || die "build failed"
}

src_test() {
	GOFLAGS="-v -x -mod=vendor" \
		go test -work ./... || die "test failed"
}

src_install() {
	einstalldocs
	dobin do-agent

	newinitd "${FILESDIR}"/do-agent.initd do-agent
	newconfd "${FILESDIR}"/do-agent.confd do-agent
	systemd_dounit "${FILESDIR}"/do-agent.service
}
