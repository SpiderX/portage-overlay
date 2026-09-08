# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Composer/CaBundle"
PHP_REQ_USE="ssl"

inherit composer

DESCRIPTION="Find the system CA bundle or fall back to the Mozilla one"
HOMEPAGE="https://github.com/composer/ca-bundle"
SRC_URI="https://github.com/composer/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="!dev-php/ca-bundle"

PATCHES=( "${FILESDIR}/${PN}"-1.5.1-res-path.patch )

COMPOSER_TEST_PATCHES=( "${FILESDIR}/${PN}"-1.5.1-tests.patch )
composer_enable_tests phpunit

src_install() {
	composer_src_install

	insinto /usr/share/composer/res
	doins -r res/.
}
