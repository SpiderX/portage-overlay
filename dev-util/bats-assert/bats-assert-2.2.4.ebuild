# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

DESCRIPTION="Common assertions for Bats"
HOMEPAGE="https://github.com/bats-core/bats-assert"
SRC_URI="https://github.com/bats-core/bats-assert/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="CC0-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

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
