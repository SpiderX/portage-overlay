# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit git-r3

DESCRIPTION="Common assertions for Bats"
HOMEPAGE="https://github.com/bats-core/bats-assert"
EGIT_REPO_URI="https://github.com/bats-core/${PN}.git"

LICENSE="CC0-1.0"
SLOT="0"

RDEPEND="dev-util/bats
	dev-util/bats-support"
DEPEND="${RDEPEND}"

src_test() {
	BATS_LIB_PATH=/usr/share edo bats test
}

src_install() {
	einstalldocs
	insinto /usr/share/bats-assert
	doins -r src load.bash
}
