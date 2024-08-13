# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//daverandom-/}"
MY_P="LibDNS-${PV}"

DESCRIPTION="DNS implementation in pure PHP"
HOMEPAGE="https://github.com/DaveRandom/LibDNS"
SRC_URI="https://github.com/DaveRandom/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # composer doesn't load tests

RDEPEND="dev-lang/php:*[ctype]
	dev-php/fedora-autoloader"

src_install() {
	einstalldocs
	insinto /usr/share/php/LibDNS
	doins -r "${FILESDIR}"/autoload.php src/.
}
