# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/dbcrossbar/${PN}.git"

inherit cargo git-r3

DESCRIPTION="Copy tabular data between databases, CSV files and cloud storage"
HOMEPAGE="https://www.dbcrossbar.org"
SRC_URI=""

LICENSE="Apache-2.0 BSD ISC MIT ZLIB"
KEYWORDS=""
SLOT="0"

DOCS=( {CHANGELOG,DESIGN,README}.md )

QA_FLAGS_IGNORED="usr/bin/dbcrossbar"

src_unpack() {
	git-r3_src_unpack
	cargo_src_unpack
}

src_install() {
	einstalldocs
	cargo_src_install --path dbcrossbar
}
