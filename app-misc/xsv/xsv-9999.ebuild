# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/BurntSushi/${PN}.git"

inherit cargo git-r3

DESCRIPTION="A fast CSV command line toolkit"
HOMEPAGE="https://github.com/BurntSushi/xsv"
SRC_URI="$(cargo_crate_uris ${CRATES})"

LICENSE="MIT Unlicense"
KEYWORDS=""
SLOT="0"
IUSE="test"
RESTRICT="mirror"

src_unpack() {
	git-r3_src_unpack
	cargo_src_unpack
}

src_test() {
	cargo test --all || die "tests failed"
}
