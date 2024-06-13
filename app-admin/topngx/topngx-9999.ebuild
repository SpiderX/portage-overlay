# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2086

EAPI=8

EGIT_REPO_URI="https://github.com/gsquire/${PN}.git"

inherit cargo git-r3

DESCRIPTION="A top for NGINX"
HOMEPAGE="https://github.com/gsquire/topngx"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-db/sqlite:3"

QA_FLAGS_IGNORED="usr/bin/topngx"

src_unpack() {
	git-r3_src_unpack
	cargo_src_unpack
}

src_install() {
	einstalldocs
	cargo_src_install
}
