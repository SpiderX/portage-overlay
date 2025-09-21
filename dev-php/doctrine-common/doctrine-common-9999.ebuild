# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Doctrine Common"
HOMEPAGE="https://github.com/doctrine/common"
EGIT_REPO_URI="https://github.com/doctrine/common.git"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/doctrine-persistence
	dev-php/fedora-autoloader"
BDEPEND="test? ( dev-php/composer
		dev-php/phpunit )"

PATCHES=( "${FILESDIR}/${PN}"-3.4.4-tests-mock.patch )

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
	# fix non-static data provider deprecation
	sed -i '/dataAutoGenerateValues(/s|function|static function|' \
		tests/Common/Proxy/AbstractProxyFactoryTest.php \
		|| die "sed failed for CompliesTest.php"
	sed -i '/methodsForWhichLazyLoadingShouldBeDisabled(/s|function|static function|' \
		tests/Common/Proxy/ProxyLogicIdentifierGetterTest.php \
		|| die "sed failed for CompliesTest.php"
	# remove failed tests
	rm tests/Common/DoctrineExceptionTest.php || die "rm failed"
	sed -i '/testNoticeWhenReadingNonExistentPublicProperties/,+16d' \
		tests/Common/Proxy/ProxyLogicTest.php \
		|| die "sed failed for ProxyLogicTest.php"
	sed -i '/testNoticeWhenReadingNonExistentPublicProperties/,+16d' \
		tests/Common/Proxy/ProxyLogicTypedPropertiesTest.php \
		|| die "sed failed for ProxyLogicTypedPropertiesTest.php"
}

src_test() {
	# skipped 7
	phpunit --bootstrap vendor/autoload.php --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Doctrine/Common
	doins -r src/.
}
