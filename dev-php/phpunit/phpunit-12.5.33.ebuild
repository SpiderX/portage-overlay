# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="PHPUnit"
PHP_MIN_VER="8.3"
PHP_REQ_USE="xml,xmlwriter,unicode"

inherit composer

DESCRIPTION="The PHP Unit Testing framework"
HOMEPAGE="https://github.com/sebastianbergmann/phpunit"
SRC_URI="https://github.com/sebastianbergmann/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test" # no tests

RDEPEND="dev-php/myclabs-deep-copy
	>=dev-php/phar-io-manifest-2.0.4
	>=dev-php/phar-io-version-3.2.1
	dev-php/phpunit-php-code-coverage
	dev-php/phpunit-php-file-iterator
	dev-php/phpunit-php-invoker
	dev-php/phpunit-php-text-template
	dev-php/phpunit-php-timer
	dev-php/sebastian-cli-parser
	dev-php/sebastian-comparator
	>=dev-php/sebastian-diff-7
	>=dev-php/sebastian-environment-8
	dev-php/sebastian-exporter
	dev-php/sebastian-global-state
	dev-php/sebastian-object-enumerator
	dev-php/sebastian-recursion-context
	>=dev-php/sebastian-type-6
	>=dev-php/sebastian-version-6
	dev-php/staabm-side-effects-detector"
BDEPEND=">=dev-php/theseer-Autoload-1.29.1"

PATCHES=( "${FILESDIR}/${PN}"-10.5.27-autoload-resources.patch )

DOCS=( {ChangeLog-12.5,DEPRECATIONS,README}.md )

src_prepare() {
	default

	edo phpab -q -o src/autoload.php -t "${FILESDIR}"/autoload.php.tpl src
}

src_install() {
	composer_src_install
	# install files into COMPOSER_INSTALL_PATH
	doins -r schema phpunit.xsd
	dobin phpunit
}
