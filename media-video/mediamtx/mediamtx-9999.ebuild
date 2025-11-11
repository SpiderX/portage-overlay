# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo git-r3 go-module systemd

HLSJS_PV="1.6.13"

DESCRIPTION="SRT / WebRTC / RTSP / RTMP / LL-HLS / MPEG-TS / RTP media server"
HOMEPAGE="https://github.com/bluenviron/mediamtx"
EGIT_REPO_URI="https://github.com/bluenviron/${PN}.git"
SRC_URI="https://cdn.jsdelivr.net/npm/hls.js@v${HLSJS_PV}/dist/hls.min.js -> hls-${HLSJS_PV}.min.js"

LICENSE="MIT"
SLOT="0"

RDEPEND="acct-group/mediamtx
	acct-user/mediamtx"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_prepare() {
	default

	# place hls.min.js and set version
	edo cp "${DISTDIR}"/hls-"${HLSJS_PV}".min.js internal/servers/hls/hls.min.js
	edo echo "${PV}" > internal/core/VERSION

	# adjust logging
	sed -i  -e '/logDestinations/s|stdout|file|'\
		-e '/logFile/s|: |: /var/log/medamtx/|' \
		mediamtx.yml || die "sed failed for mediamtx.yml"
}

src_compile() {
	ego build
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs

	dobin mediamtx
	insinto /etc/mediamtx
	doins mediamtx.yml
	dodoc api/openapi.yaml

	newinitd "${FILESDIR}"/mediamtx.initd mediamtx
	newinitd "${FILESDIR}"/mediamtx.confd mediamtx
	systemd_dounit "${FILESDIR}"/mediamtx.service

	insinto /etc/logrotate.d/
	newins "${FILESDIR}"/mediamtx.logrotate mediamtx.conf
}
