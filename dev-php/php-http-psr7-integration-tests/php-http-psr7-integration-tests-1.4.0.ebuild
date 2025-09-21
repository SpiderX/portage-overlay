# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//php-http-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A PSR-7 implementation tests"
HOMEPAGE="https://github.com/php-http/psr7-integration-tests"
SRC_URI="https://github.com/php-http/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test" # needs tests from other packages

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/phpunit
	dev-php/psr-http-message"

DOCS=( {CHANGELOG,README}.md )

src_install() {
	einstalldocs
	insinto /usr/share/php/Http/Psr7Test
	doins -r "${FILESDIR}"/autoload.php src/.
}
