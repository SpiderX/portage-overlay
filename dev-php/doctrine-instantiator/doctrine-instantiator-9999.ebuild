# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/doctrine/instantiator.git"

inherit git-r3

DESCRIPTION="Doctrine Instantiator"
HOMEPAGE="https://github.com/doctrine/instantiator"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*[pdo]
	dev-php/fedora-autoloader"
BDEPEND="test? ( dev-php/phpunit )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/Doctrine/Instantiator/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
	# repalce deprecated method
	sed -i '/self::assertObject/s|Attribute|Property|' \
		tests/DoctrineTest/InstantiatorTest/InstantiatorTest.php \
		|| die "sed failed for InstantiatorTest.php"
}

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php
	doins -r src/.
}
