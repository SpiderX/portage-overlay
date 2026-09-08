# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Composer/Spdx"

inherit composer

DESCRIPTION="Tools for working with and validating SPDX licenses"
HOMEPAGE="https://github.com/composer/spdx-licenses"
SRC_URI="https://github.com/composer/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="!dev-php/spdx-licenses"

PATCHES=( "${FILESDIR}/${PN}"-1.5.8-res-path.patch )

EPHPUNIT_BOOTSTRAP='tmp/fake/src/autoload.php'
# exclude tests for non-existed class
EPHPUNIT_EXCLUDE_FILTER='testDump(Licenses|Exceptions)'
COMPOSER_TEST_PATCHES=( "${FILESDIR}/${PN}"-1.6.0-tests.patch )
composer_enable_tests phpunit

src_prepare() {
	composer_src_prepare

	# mimic system path for bootstrap
	edo mkdir -p composer tmp/fake
	edo ln -s -t composer ../res
}

src_test() {
	composer_prepare_tests
	# mimic system path for bootstrap
	edo cp -a src tests tmp/fake
	ephpunit tmp/fake/tests
}

src_install() {
	composer_src_install

	insinto /usr/share/composer/res
	doins -r res/.
}
