# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/php-cache/integration-tests.git"

inherit git-r3

DESCRIPTION="Integration tests for PSR-6 cache"
HOMEPAGE="https://github.com/php-cache/integration-tests"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # needs tests from other packages

RDEPEND="dev-lang/php:*
	dev-php/cache
	dev-php/fedora-autoloader
	dev-php/psr-cache"

src_install() {
	einstalldocs
	insinto /usr/share/php/Cache/IntegrationTests
	doins -r "${FILESDIR}"/autoload.php src/.
}
