# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo git-r3

DESCRIPTION="A log view in various timezones"
HOMEPAGE="https://github.com/thecasualcoder/tztail"
EGIT_REPO_URI="https://github.com/thecasualcoder/${PN}.git"

LICENSE="Apache-2.0 Boost-1.0 MIT MPL-2.0 Unlicense"
SLOT="0"

QA_FLAGS_IGNORED="usr/bin/tztail"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_install() {
	einstalldocs
	cargo_src_install
}
