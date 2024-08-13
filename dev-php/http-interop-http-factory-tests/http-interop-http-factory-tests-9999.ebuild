# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/http-interop/http-factory-tests.git"

inherit git-r3

DESCRIPTION="Unit tests for HTTP Factory implementations"
HOMEPAGE="https://github.com/http-interop/http-factory-tests"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/phpunit
	dev-php/psr-http-factory"

src_install() {
	einstalldocs
	insinto /usr/share/php/Interop/Http/Factory
	doins -r "${FILESDIR}"/autoload.php test/.
}
