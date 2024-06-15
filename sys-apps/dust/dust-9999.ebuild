# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/chmln/${PN}.git"

inherit cargo git-r3

DESCRIPTION="More intuitive version of du"
HOMEPAGE="https://github.com/bootandy/dust"

LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 MIT Unlicense"
SLOT="0"

QA_PREBUILT="usr/bin/dust"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_install() {
	einstalldocs
	cargo_src_install
}
