# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Amp/Http"

inherit composer git-r3

DESCRIPTION="HTTP primitives which can be shared by servers and clients"
HOMEPAGE="https://github.com/amphp/http"
EGIT_REPO_URI="https://github.com/amphp/http.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-php/amphp-hpack
	dev-php/amphp-parser
	dev-php/league-uri-components
	dev-php/psr-http-message"

PATCHES=( "${FILESDIR}/${PN}"-2.1.2-tests-HttpResponseTest.patch
	"${FILESDIR}/${PN}"-2.1.2-tests-ParseHeaderFieldsTest.patch
	"${FILESDIR}/${PN}"-2.1.2-tests-phpunit.xml.patch
	"${FILESDIR}/${PN}"-2.1.2-tests-Rfc7230Test.patch
	"${FILESDIR}/${PN}"-2.1.2-tests-SplitHeaderTest.patch )

composer_enable_tests phpunit

src_test() {
	edo php -d zend.assertions=1 /usr/bin/phpunit --testdox
}
