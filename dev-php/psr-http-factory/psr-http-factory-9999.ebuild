# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Implementation of PSR-17 (HTTP Message Factories)"
HOMEPAGE="https://github.com/php-fig/http-factory"
EGIT_REPO_URI="https://github.com/php-fig/http-factory.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/psr-http-message"

src_install() {
	einstalldocs
	insinto /usr/share/php/Psr/Http/Message
	doins -r src/.
	insinto /usr/share/php/Psr/Http/Message/Factory
	doins "${FILESDIR}"/autoload.php
}
