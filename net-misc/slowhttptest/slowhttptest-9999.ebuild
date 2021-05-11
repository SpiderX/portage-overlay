# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/shekyan/${PN}.git"

inherit git-r3

DESCRIPTION="Application Layer DoS attack simulator"
HOMEPAGE="https://github.com/shekyan/slowhttptest"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

DEPEND="dev-libs/openssl:0="
RDEPEND="${DEPEND}"
