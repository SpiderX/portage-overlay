# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo git-r3

DESCRIPTION="Command line csv viewer"
HOMEPAGE="https://github.com/YS-L/csvlens"
EGIT_REPO_URI="https://github.com/YS-L/${PN}.git"

LICENSE="Apache-2.0 Boost-1.0 CC0-1.0 MIT Unicode-3.0 ZLIB"
SLOT="0"

DOCS=( {CHANGELOG,README}.md )

QA_FLAGS_IGNORED="usr/bin/csvlens"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_test() {
	CI=1 cargo_src_test
}

src_install() {
	einstalldocs
	cargo_src_install
}
