# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="PharIo/Manifest"
COMPOSER_VENDOR="${PN%-*}"
COMPOSER_PKG="${PN##*-}"
PHP_REQ_USE="phar,xml(-),xmlwriter(-)"

inherit composer

DESCRIPTION="Reading phar.io manifest information from a PHP Archive (PHAR)"
HOMEPAGE="https://github.com/phar-io/manifest"
SRC_URI="https://github.com/phar-io/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-php/phar-io-version-3.2.1"
BDEPEND="dev-php/theseer-Autoload"

DOCS=( {CHANGELOG,README}.md )

COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-2.0.4-tests-ManifestDocumentMapperTest.patch
	"${FILESDIR}/${PN}"-2.0.4-tests-ManifestSerializerTest.patch )
composer_enable_tests phpunit

src_prepare() {
	composer_src_prepare

	edo phpab -q -o src/autoload.php -t "${FILESDIR}"/autoload.php.tpl src
}
