# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//phpunit-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="TextUI frontend for php-code-coverage"
HOMEPAGE="https://github.com/sebastianbergmann/phpcov"
SRC_URI="https://phar.phpunit.de/${MY_P}.phar"
S="${WORKDIR}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*[phar]
	dev-php/xdebug"

src_unpack() {
	return
}

src_install() {
	exeinto /usr/share/php/phpcov
	newexe "${DISTDIR}/${MY_P}".phar phpcov.phar
	dosym ../share/php/phpcov/phpcov.phar /usr/bin/phpcov
}
