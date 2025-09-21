# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Common interfaces for HTTP Client"
HOMEPAGE="https://github.com/php-fig/http-client"
EGIT_REPO_URI="https://github.com/php-fig/http-client.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/psr-http-message"

DOCS=( {CHANGELOG,README}.md )

src_install() {
	einstalldocs
	insinto /usr/share/php/Psr/Http/Client
	doins -r "${FILESDIR}"/autoload.php src/.
}
