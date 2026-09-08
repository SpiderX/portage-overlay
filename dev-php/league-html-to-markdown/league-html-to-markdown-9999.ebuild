# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="League/HTMLToMarkdown"
PHP_REQ_USE="xml"

inherit composer git-r3

DESCRIPTION="HTML To Markdown for PHP"
HOMEPAGE="https://github.com/thephpleague/html-to-markdown"
EGIT_REPO_URI="https://github.com/thephpleague/html-to-markdown.git"

LICENSE="MIT"
SLOT="0"

BDEPEND="test? ( dev-php/mikehaertl-php-shellcommand )"

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
