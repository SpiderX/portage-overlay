# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Application Layer DoS attack simulator"
HOMEPAGE="https://github.com/shekyan/slowhttptest"
EGIT_REPO_URI="https://github.com/shekyan/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"

DEPEND="dev-libs/openssl:0="
RDEPEND="${DEPEND}"
