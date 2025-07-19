# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="CLI tool (similar to jq) to query JSON using sane DSL"
HOMEPAGE="https://github.com/jsqry/jsqry-cli2"
SRC_URI="https://github.com/jsqry/jsqry-cli2/releases/download/v${PV}/jsqry-linux-amd64"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_unpack() { :; }

src_install() {
	newbin "${DISTDIR}"/'${A}' jsqry
}
