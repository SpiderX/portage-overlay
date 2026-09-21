# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit git-r3

DESCRIPTION="Supporting library for Bats test helpers"
HOMEPAGE="https://github.com/bats-core/bats-support"
EGIT_REPO_URI="https://github.com/bats-core/${PN}.git"

LICENSE="0BSD CC0-1.0"
SLOT="0"

RDEPEND="dev-util/bats"
DEPEND="${RDEPEND}"

DOCS=( {CHANGELOG,README}.md )

src_test() {
	edo bats test
}

src_install() {
	einstalldocs
	insinto /usr/share/bats-support
	doins -r src load.bash
}
