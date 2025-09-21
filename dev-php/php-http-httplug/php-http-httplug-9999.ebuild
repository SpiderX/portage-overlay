# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="The HTTP client abstraction for PHP"
HOMEPAGE="https://github.com/php-http/httplug"
EGIT_REPO_URI="https://github.com/php-http/httplug.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/php-http-promise
	dev-php/psr-http-client
	dev-php/psr-http-message"

DOCS=( {CHANGELOG,README}.md )

src_install() {
	einstalldocs
	insinto /usr/share/php/Http/Client
	doins -r "${FILESDIR}"/autoload.php src/.
}
