# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/aler9/${PN}.git"

inherit git-r3 go-module systemd

DESCRIPTION="RTSP server and RTSP proxy to read, publish and proxy media stream"
HOMEPAGE="https://github.com/aler9/rtsp-simple-server"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""
RESTRICT="test" # needs docker

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_compile() {
	LDFLAGS="-X main.version=${PV}"
	go build -ldflags="${LDFLAGS}" || die "build failed"
}

src_test() {
	go test -work || die "test failed"
}

src_install() {
	einstalldocs
	dobin rtsp-simple-server
	insinto /etc/rtsp-simple-server
	doins rtsp-simple-server.yml

	newinitd "${FILESDIR}"/rtsp-simple-server.initd rtsp-simple-server
	newconfd "${FILESDIR}"/rtsp-simple-server.confd rtsp-simple-server
	systemd_dounit "${FILESDIR}"/rtsp-simple-server.service
}
