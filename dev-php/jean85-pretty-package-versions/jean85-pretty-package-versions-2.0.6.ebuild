# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//jean85-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Independent wrapper to get pretty versions strings"
HOMEPAGE="https://github.com/Jean85/pretty-package-versions"
SRC_URI="https://github.com/Jean85/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # tests require useless packages

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"

src_install() {
	einstalldocs
	insinto /usr/share/php/Jean85
	doins -r "${FILESDIR}"/autoload.php src/.
}
