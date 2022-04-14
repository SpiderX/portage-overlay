# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/chmln/${PN}.git"

inherit cargo git-r3

DESCRIPTION="More intuitive version of du"
HOMEPAGE="https://github.com/bootandy/dust"
SRC_URI=""

LICENSE="Apache-2.0 BSD MIT"
SLOT="0"
KEYWORDS=""

QA_FLAGS_IGNORED="usr/bin/dust"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}
