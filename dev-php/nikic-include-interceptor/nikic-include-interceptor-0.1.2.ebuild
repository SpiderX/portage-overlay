# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="nikic/IncludeInterceptor"

inherit composer

DESCRIPTION="A library to intercept PHP includes"
HOMEPAGE="https://github.com/nikic/include-interceptor"
SRC_URI="https://github.com/nikic/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( dev-php/phpunit )"

PATCHES=( "${FILESDIR}/${PN}"-0.1.2-tests-FileFilterTest.patch
	"${FILESDIR}/${PN}"-0.1.2-tests-IncludePathTest.patch
	"${FILESDIR}/${PN}"-0.1.2-tests-InterceptorTests.patch
	"${FILESDIR}/${PN}"-0.1.2-tests-phpunit.xml.patch )

src_test() {
	ephpunit
}
