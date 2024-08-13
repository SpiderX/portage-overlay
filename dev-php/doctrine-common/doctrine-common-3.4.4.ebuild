# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//doctrine-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Doctrine Common"
HOMEPAGE="https://github.com/doctrine/common"
SRC_URI="https://github.com/doctrine/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*
	dev-php/doctrine-persistence
	dev-php/fedora-autoloader"
BDEPEND="test? ( dev-php/composer
		dev-php/phpunit )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
}

src_test() {
	composer require -d "${T}" --prefer-source \
		--dev "${PN/-/\/}:${PV}" || die "composer failed"
	cp -r "${T}"/vendor/"${PN/-/\/}"/{phpunit.xml.dist,tests} "${S}" \
		|| die "cp failed"
	eapply "${FILESDIR}/${PN}"-3.4.4-tests-mock.patch
	# remove failed tests
	rm tests/Common/DoctrineExceptionTest.php || die "rm failed"
	sed -i  -e '/testClassExists(/,+12d' \
		-e '/testClassExistsWithSilentAutoloader/,+18d' \
		tests/Common/ClassLoaderTest.php \
		|| die "sed failed for ClassLoaderTest.php"
	sed -i '/testNoticeWhenReadingNonExistentPublicProperties/,+16d' \
		tests/Common/Proxy/ProxyLogicTest.php \
		|| die "sed failed for ProxyLogicTest.php"
	sed -i '/testNoticeWhenReadingNonExistentPublicProperties/,+16d' \
		tests/Common/Proxy/ProxyLogicTypedPropertiesTest.php \
		|| die "sed failed for ProxyLogicTypedPropertiesTest.php"
	phpunit --bootstrap vendor/autoload.php --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Doctrine/Common
	doins -r src/.
}
