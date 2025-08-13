# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo git-r3

DESCRIPTION="Ping, but with a graph"
HOMEPAGE="https://github.com/orf/gping"
EGIT_REPO_URI="https://github.com/orf/${PN}.git"

LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 MIT MIT-0 Unlicense ZLIB"
SLOT="0"
RESTRICT="mirror"

QA_FLAGS_IGNORED="usr/bin/gping"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_install() {
	einstalldocs
	doman gping.1
	dobin target/release/gping
}
