# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature git-r3

DESCRIPTION="Doctrine Data Fixtures Extension"
HOMEPAGE="https://github.com/doctrine/data-fixtures"
EGIT_REPO_URI="https://github.com/doctrine/data-fixtures.git"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*[pdo,sqlite]
	dev-php/doctrine-persistence
	dev-php/fedora-autoloader"
BDEPEND="test? ( dev-php/doctrine-orm
		dev-php/phpunit
		dev-php/symfony-cache )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
}

src_test() {
	# skipped 7
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Doctrine/Common/DataFixtures
	doins -r src/.
}

pkg_postinst() {
	optfeature "Loading ORM fixtures" dev-php/doctrine-orm
}
