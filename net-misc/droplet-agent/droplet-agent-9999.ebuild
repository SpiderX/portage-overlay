# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module systemd

DESCRIPTION="DigitalOcean Droplet Agent"
HOMEPAGE="https://github.com/digitalocean/droplet-agent"
EGIT_REPO_URI="https://github.com/digitalocean/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"
RESTRICT="test"
PROPERTIES="test_network"

DOCS=( {CHANGELOG,README}.md )

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	default

	sed -i '/ExecStart/s|opt/digitalocean|usr|' \
		packaging/syscfg/systemd/droplet-agent.service || die "sed failed"
}

src_compile() {
	LDFLAGS="-X main.version=${PV} -X main.buildDate=${PV}"
	ego build -ldflags "${LDFLAGS}" -o droplet-agent ./cmd/agent/
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin droplet-agent

	newinitd "${FILESDIR}"/droplet-agent.initd droplet-agent
	newconfd "${FILESDIR}"/droplet-agent.confd droplet-agent
	systemd_dounit packaging/syscfg/systemd/droplet-agent.service
}
