# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd

COMMIT="0dfcad2"

DESCRIPTION="DigitalOcean Agent for Enhanced Droplet Graphs"
HOMEPAGE="https://github.com/digitalocean/do-agent"
SRC_URI="https://github.com/digitalocean/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_compile() {
	DATE="$(date -u)"
	LDFLAGS="-w -X main.version=${PV} -X main.revision=${COMMIT}
		-X \"main.buildDate=${DATE}\""
	GOFLAGS="-v -x -mod=vendor" \
		ego build -ldflags "${LDFLAGS}" ./cmd/do-agent/...
}

src_test() {
	GOFLAGS="-v -x -mod=vendor" ego test -work ./...
}

src_install() {
	einstalldocs
	dobin do-agent

	newinitd "${FILESDIR}"/do-agent.initd do-agent
	newconfd "${FILESDIR}"/do-agent.confd do-agent
	systemd_dounit "${FILESDIR}"/do-agent.service
}
