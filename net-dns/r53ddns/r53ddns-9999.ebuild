# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2086

EAPI=7

EGIT_REPO_URI="https://github.com/coord-e/${PN}.git"

inherit cargo git-r3 systemd

DESCRIPTION="Updates A record in Route53 with current global IP"
HOMEPAGE="https://github.com/coord-e/r53ddns"
SRC_URI="$(cargo_crate_uris ${CRATES})"

LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2
	BSD BSL-1.1 CC0-1.0 MIT Unlicense"
SLOT="0"
KEYWORDS=""
IUSE=""
RESTRICT="mirror"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_install() {
	einstalldocs
	newinitd "${FILESDIR}"/r53ddns.initd r53ddns
	newconfd "${FILESDIR}"/r53ddns.confd r53ddns
	systemd_dounit "${FILESDIR}"/r53ddns.service

	cargo_src_install
}
