# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//cache-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Integration tests for PSR-6 cache"
HOMEPAGE="https://github.com/php-cache/integration-tests"
SRC_URI="https://github.com/php-cache/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # needs tests from other packages

RDEPEND="dev-lang/php:*
	dev-php/cache
	dev-php/fedora-autoloader
	dev-php/psr-cache"

src_install() {
	einstalldocs
	insinto /usr/share/php/Cache/IntegrationTests
	doins -r "${FILESDIR}"/autoload.php src/.
}
