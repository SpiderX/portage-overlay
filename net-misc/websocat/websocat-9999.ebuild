# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2086

EAPI=8

EGIT_REPO_URI="https://github.com/vi/${PN}.git"

inherit cargo git-r3

DESCRIPTION="Netcat, curl and socat for WebSockets"
HOMEPAGE="https://github.com/vi/websocat"

LICENSE="0BSD Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD BSD-2 ISC MIT Unlicense ZLIB"
SLOT="0"
IUSE="ssl"

RDEPEND="ssl? ( dev-libs/openssl:0= )"
DEPEND="${RUST_DEPEND}
	${RDEPEND}"

DOCS=( {doc,moreexamples,README}.md )

QA_FLAGS_IGNORED="usr/bin/websocat"

src_unpack() {
	git-r3_src_unpack
	cargo_src_unpack
}

src_configure() {
	local myfeatures=(
		"$(usex ssl ssl '')"
		seqpacket
		signal_handler
		tokio-process
		unix_stdio
	)
	cargo_src_configure --no-default-features
}

src_install() {
	einstalldocs
	cargo_src_install
}
