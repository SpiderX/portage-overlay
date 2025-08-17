# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo git-r3

DESCRIPTION="Copy tabular data between databases, CSV files and cloud storage"
HOMEPAGE="https://www.dbcrossbar.org"
EGIT_REPO_URI="https://github.com/dbcrossbar/${PN}.git"

LICENSE="Apache-2.0 BSD CC0-1.0 ISC MIT MPL-2.0 Unicode-DFS-2016 ZLIB"
SLOT="0"

DOCS=( {CHANGELOG,DESIGN,README}.md )

QA_FLAGS_IGNORED="usr/bin/dbcrossbar"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_install() {
	einstalldocs
	cargo_src_install --path dbcrossbar
}
