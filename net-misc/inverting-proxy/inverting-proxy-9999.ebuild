# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo git-r3 go-module

DESCRIPTION="Reverse proxy that inverts the direction of traffic"
HOMEPAGE="https://github.com/google/inverting-proxy"
EGIT_REPO_URI="https://github.com/google/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="agent server test"
REQUIRED_USE="|| ( agent server )"
RESTRICT="!test? ( test )"

src_unpack() {
	git-r3_src_unpack
	edo pushd "${S}"
	edo go mod tidy
	edo popd
	go-module_live_vendor
}

src_compile() {
	use agent && ego build -o ./bin/proxy-forwarding-agent ./agent/agent.go
	use server && ego build -o ./bin/inverting-proxy ./server/server.go
	if use test ; then
		ego build -o ./bin/inverting-proxy-run-local \
			./testing/runlocal/main.go
		ego build -o ./bin/inverting-proxy-run-websockets \
			./testing/websockets/main.go
		ego build -o ./bin/example-websocket-server \
			./testing/websockets/example/main.go
	fi
}

src_test() {
	ego test -work ./agent/{banner,metrics,sessions,utils,websockets}/...
}

src_install() {
	einstalldocs

	if use agent ; then
		dobin bin/proxy-forwarding-agent
		newinitd "${FILESDIR}"/inverting-proxy-agent.initd inverting-proxy-agent
		newconfd "${FILESDIR}"/inverting-proxy-agent.confd inverting-proxy-agent
	fi
	if use server ; then
		dobin bin/inverting-proxy
		newinitd "${FILESDIR}"/inverting-proxy-server.initd inverting-proxy-server
		newconfd "${FILESDIR}"/inverting-proxy-server.confd inverting-proxy-server
	fi
}
