# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo git-r3

DESCRIPTION="Like jq, but for HTML"
HOMEPAGE="https://github.com/mgdm/htmlq"
EGIT_REPO_URI="https://github.com/mgdm/${PN}.git"

LICENSE="MIT MPL-2.0"
SLOT="0"

QA_FLAGS_IGNORED="usr/bin/htmlq"

src_unpack() {
	git-r3_src_unpack
	cargo_src_unpack
}

src_install() {
	einstalldocs
	cargo_src_install
}
