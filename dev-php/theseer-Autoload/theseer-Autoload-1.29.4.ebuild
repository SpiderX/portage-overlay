# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="TheSeer/Autoload"
COMPOSER_VENDOR="${PN%%-*}"
COMPOSER_PKG="Autoload"
PHP_REQ_USE="cli,fileinfo(-),ssl,tokenizer(-)"

inherit composer

DESCRIPTION="PHP Autoload Builder"
HOMEPAGE="https://github.com/theseer/Autoload"
SRC_URI="https://github.com/theseer/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-php/theseer-DirectoryScanner
	dev-php/zetacomponents-Base
	dev-php/zetacomponents-ConsoleTools"
BDEPEND="test? ( dev-php/phpunit )"

PATCHES=( "${FILESDIR}/${PN}"-1.26.0-autoload.php.patch
	"${FILESDIR}/${PN}"-1.29.4-tests.patch )

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	# set version
	sed -i "s/%development%/${PV}/" phpab.php composer/bin/phpab || die "sed failed for phpab"
	# add templates
	edo install -D -m 644 "${FILESDIR}"/fedora{,2}.php.tpl src/templates/ci
	# create bootstrap stracture
	edo mkdir -p vendor/theseer/directoryscanner \
		vendor/zetacomponents/{base,console-tools}
	edo ln -s ../../../../../../../../../../usr/share/php/TheSeer/DirectoryScanner \
		vendor/theseer/directoryscanner/src
	edo ln -s ../../../../../../../../../../usr/share/php/ezc/Base \
		vendor/zetacomponents/base/src
	edo ln -s ../../../../../../../../../../usr/share/php/ezc/ConsoleTools \
		vendor/zetacomponents/console-tools/src
	edo ./phpab.php -q -o src/autoload.php -t "${FILESDIR}"/autoload.php.tpl src
}

src_test() {
	ephpunit
}

src_install() {
	composer_src_install

	dobin composer/bin/phpab
}
