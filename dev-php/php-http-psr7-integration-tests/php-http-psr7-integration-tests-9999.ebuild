# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/php-http/psr7-integration-tests.git"

inherit git-r3

DESCRIPTION="A PSR-7 implementation tests"
HOMEPAGE="https://github.com/php-http/psr7-integration-tests"

LICENSE="MIT"
SLOT="0"
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
