# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_AUTOLOAD="library"
COMPOSER_INSTALL_PATH="Mockery"
COMPOSER_INSTALL_SRC="library/Mockery"

inherit composer

DESCRIPTION="Flexible PHP mock object framework"
HOMEPAGE="https://github.com/mockery/mockery"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/hamcrest"

DOCS=( {CHANGELOG,README}.md )

# hangs under Portage when testing a mocked never-returning method in a forked child
EPHPUNIT_EXCLUDE_FILTER='testItCanMockAClassWithANeverReturningTypeHintWithExit'
COMPOSER_TEST_PATCHES=( "${FILESDIR}/${PN}"-1.6.15-tests.patch )
composer_enable_tests phpunit

src_install() {
	composer_src_install
	# install files into COMPOSER_INSTALL_PATH
	doins library/{autoload,helpers,Mockery}.php
}
