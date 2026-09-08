# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="GuzzleHttp/Psr7"

inherit composer git-r3

DESCRIPTION="PSR-7 HTTP message library"
HOMEPAGE="https://github.com/guzzle/psr7"
EGIT_REPO_URI="https://github.com/guzzle/psr7.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-php/psr-http-factory
	dev-php/psr-http-message
	dev-php/ralouphie-getallheaders"
BDEPEND="test? ( dev-php/http-interop-http-factory-tests )"

composer_enable_tests phpunit

src_prepare() {
	composer_src_prepare

	edo mkdir -p vendor/http-interop/http-factory-tests
	edo ln -s ../../../../../../../../../../usr/share/php/Interop/Http/Factory/ \
		vendor/http-interop/http-factory-tests/test
}

src_compile() { :; }
