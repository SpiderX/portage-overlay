# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd

DESCRIPTION="DigitalOcean Droplet Agent"
HOMEPAGE="https://github.com/digitalocean/droplet-agent"
SRC_URI="https://github.com/digitalocean/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # needs net

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	sed -i '/ExecStart/s|opt/digitalocean|usr|' \
		packaging/syscfg/systemd/droplet-agent.service || die "sed failed"
}

src_compile() {
	LDFLAGS="-X main.version=${PV} -X main.buildDate=${PV} -s -w"
	GOFLAGS="-v -x -mod=vendor" ego build -ldflags "${LDFLAGS}" \
		-o droplet-agent ./cmd/agent/
}

src_test() {
	GOFLAGS="-v -x -mod=vendor" ego test -work ./...
}

src_install() {
	einstalldocs
	dobin droplet-agent

	newinitd "${FILESDIR}"/droplet-agent.initd droplet-agent
	newconfd "${FILESDIR}"/droplet-agent.confd droplet-agent
	systemd_dounit packaging/syscfg/systemd/droplet-agent.service
}
