# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2086

EAPI=8

EGIT_REPO_URI="https://github.com/thecasualcoder/${PN}.git"

inherit cargo git-r3

DESCRIPTION="A log view in various timezones"
HOMEPAGE="https://github.com/thecasualcoder/tztail"

LICENSE="MIT"
SLOT="0"

src_unpack() {
	git-r3_src_unpack
	cargo_src_unpack
}

src_install() {
	einstalldocs
	cargo_src_install
}
