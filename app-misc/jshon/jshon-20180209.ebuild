# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

COMMIT="d919aeaece37962251dbe6c1ee50f0028a5c90e4"

DESCRIPTION="JSON parser designed for maximum convenience within the shell"
HOMEPAGE="http://kmkeen.com/jshon/ https://github.com/keenerd/jshon"
SRC_URI="https://github.com/keenerd/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-libs/jansson"
RDEPEND="${DEPEND}"

src_compile() {
	emake CC="$(tc-getCC)"
}
