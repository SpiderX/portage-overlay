# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/google/${PN}.git"

inherit git-r3 go-module

DESCRIPTION="Reverse proxy that inverts the direction of traffic"
HOMEPAGE="https://github.com/google/inverting-proxy"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="agent server test"
REQUIRED_USE="|| ( agent server )"
RESTRICT="!test? ( test )"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	if use agent ; then
		go build -o ./bin/proxy-forwarding-agent ./agent/agent.go \
		|| die "agent build failed"
	fi
	if use server ; then
		go build -o ./bin/inverting-proxy ./server/server.go \
		|| die "server build failed"
	fi
	if use test ; then
		go build -o ./bin/inverting-proxy-run-local \
			./testing/runlocal/main.go \
			|| die "build inverting-proxy-run-local failed"
		go build -o ./bin/inverting-proxy-run-websockets \
			./testing/websockets/main.go \
			|| die "build inverting-proxy-run-websockets failed"
		go build -o ./bin/example-websocket-server \
			./testing/websockets/example/main.go \
			|| die "build example-websocket-server failed"
	fi
}

src_test() {
	go test -work ./agent/{banner,metrics,sessions,utils,websockets}/... \
		|| die "test failed"
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
