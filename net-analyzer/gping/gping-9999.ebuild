# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2086

EAPI=8

EGIT_REPO_URI="https://github.com/orf/${PN}.git"

inherit cargo git-r3

DESCRIPTION="Ping, but with a graph"
HOMEPAGE="https://github.com/orf/gping"

LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 MIT MIT-0 Unlicense ZLIB"
SLOT="0"
RESTRICT="mirror"

QA_FLAGS_IGNORED="usr/bin/gping"

src_unpack() {
	git-r3_src_unpack
	cargo_src_unpack
}

src_prepare() {
	default

	# remove git2 dependency
	sed -i '/shadow-rs/!b;n;cshadow-rs = { version = "0.26.1", default-features = false }' \
		Cargo.toml || die "sed failed for Cargo.toml"
}

src_install() {
	einstalldocs
	doman "${FILESDIR}"/gping.1
	cargo_src_install
}
