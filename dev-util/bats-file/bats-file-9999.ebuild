# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit git-r3

DESCRIPTION="Common filesystem assertions for Bats"
HOMEPAGE="https://github.com/bats-core/bats-file"
EGIT_REPO_URI="https://github.com/bats-core/${PN}.git"

LICENSE="CC0-1.0"
SLOT="0"

RDEPEND="dev-util/bats
	dev-util/bats-support"
DEPEND="${RDEPEND}"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	# these tests require privileged mknod or chown operations, unavailable in the Portage sandbox
	edo rm test/54-assert-{10-assert_character_exists,11-assert_character_not_exists}.bats \
		test/55-assert-{10-assert_block_exists,11-assert_block_not_exists}.bats \
		test/59-assert-{10-assert_file_owner,11-assert_not_file_owner}.bats
}

src_test() {
	BATS_LIB_PATH=/usr/share edo bats test
}

src_install() {
	einstalldocs
	insinto /usr/share/bats-file
	doins -r src load.bash
}
