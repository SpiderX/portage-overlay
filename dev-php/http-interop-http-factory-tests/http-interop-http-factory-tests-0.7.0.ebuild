# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//http-interop-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Unit tests for HTTP Factory implementations"
HOMEPAGE="https://github.com/http-interop/http-factory-tests"
SRC_URI="https://github.com/http-interop/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/phpunit
	dev-php/psr-http-factory"

src_install() {
	einstalldocs
	insinto /usr/share/php/Interop/Http/Factory
	doins -r "${FILESDIR}"/autoload.php test/.
}
