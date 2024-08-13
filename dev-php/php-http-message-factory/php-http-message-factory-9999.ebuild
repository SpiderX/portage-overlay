# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/php-http/message-factory.git"

inherit git-r3

DESCRIPTION="Httplug Factory interfaces for PSR-7 HTTP Message"
HOMEPAGE="https://github.com/php-http/message-factory"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/psr-http-message"

DOCS=( {CHANGELOG,README}.md )

src_install() {
	einstalldocs
	insinto /usr/share/php/Http/Message
	doins -r "${FILESDIR}"/autoload.php src/.
}
