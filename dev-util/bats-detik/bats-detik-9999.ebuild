# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit git-r3

DESCRIPTION="A library to ease e2e tests of applications in K8s environments"
HOMEPAGE="https://github.com/bats-core/bats-detik"
EGIT_REPO_URI="https://github.com/bats-core/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-util/bats"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/${PN}"-1.4.0-detik.bash.patch
	"${FILESDIR}/${PN}"-1.4.0-utils.bash.patch
	"${FILESDIR}/${PN}"-1.4.0-tests.patch )

src_test() {
	local -x TMPDIR="${T}"
	edo bats tests
}

src_install() {
	einstalldocs
	insinto /usr/share/bats-detik
	doins -r lib
}
