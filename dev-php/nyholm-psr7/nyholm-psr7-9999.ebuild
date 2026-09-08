# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Nyholm/Psr7"

inherit composer git-r3

DESCRIPTION="A super lightweight PSR-7 implementation"
HOMEPAGE="https://github.com/Nyholm/psr7"
EGIT_REPO_URI="https://github.com/Nyholm/psr7.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-php/psr-http-factory
	dev-php/psr-http-message"
BDEPEND="test? ( dev-php/http-interop-http-factory-tests
		dev-php/php-http-message-factory
		dev-php/php-http-psr7-integration-tests )"

PATCHES=( "${FILESDIR}/${PN}"-1.8.2-tests-RequestTest.patch
	"${FILESDIR}/${PN}"-1.8.2-tests-ResponseTest.patch
	"${FILESDIR}/${PN}"-1.8.2-tests-UploadedFileTest.patch
	"${FILESDIR}/${PN}"-1.8.2-tests-UriTest.patch )

composer_enable_tests phpunit

src_prepare() {
	composer_src_prepare

	edo mkdir -p vendor/http-interop/http-factory-tests
	edo ln -s ../../../../../../../../../../usr/share/php/Interop/Http/Factory/ \
		vendor/http-interop/http-factory-tests/test
}
