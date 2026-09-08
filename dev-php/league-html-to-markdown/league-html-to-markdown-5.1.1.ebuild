# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="League/HTMLToMarkdown"
PHP_REQ_USE="xml"

inherit composer

DESCRIPTION="HTML To Markdown for PHP"
HOMEPAGE="https://github.com/thephpleague/html-to-markdown"
SRC_URI="https://github.com/thephpleague/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="test? ( dev-php/mikehaertl-php-shellcommand )"

COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-5.1.1-CoerceTest.patch
	"${FILESDIR}/${PN}"-5.1.1-HtmlConverterTest.patch
	"${FILESDIR}/${PN}"-5.1.1-phpunit.xml.patch )
composer_enable_tests phpunit

src_install() {
	composer_src_install
	# install files into COMPOSER_INSTALL_PATH
	doins -r bin

	exeinto /usr/share/php/"${COMPOSER_INSTALL_PATH}"
	doexe bin/html-to-markdown
	dosym ../share/php/"${COMPOSER_INSTALL_PATH}"/html-to-markdown \
		/usr/bin/html-to-markdown
}
