# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/php-fig/http-message.git"

DESCRIPTION="Common interfaces for HTTP messages"
HOMEPAGE="https://github.com/php-fig/http-message"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"

DOCS=( {CHANGELOG,README}.md )

src_install() {
	einstalldocs
	insinto /usr/share/php/Psr/Http/Message
	doins -r "${FILESDIR}"/autoload.php src/.
}
