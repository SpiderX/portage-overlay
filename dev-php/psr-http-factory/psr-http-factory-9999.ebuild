# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Psr/Http/Message"

inherit composer git-r3

DESCRIPTION="Implementation of PSR-17 (HTTP Message Factories)"
HOMEPAGE="https://github.com/php-fig/http-factory"
EGIT_REPO_URI="https://github.com/php-fig/http-factory.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-php/psr-http-message"

src_prepare() {
	default

	edo mkdir -p src/Factory
	edo phpab -q -o src/Factory/autoload.php -t "${FILESDIR}"/autoload.php.tpl src
}
