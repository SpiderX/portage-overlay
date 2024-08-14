# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/symfony/doctrine-messenger.git"

inherit git-r3

DESCRIPTION="Symfony Doctrine Messenger"
HOMEPAGE="https://github.com/symfony/doctrine-messenger"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/doctrine-dbal
	dev-php/fedora-autoloader
	dev-php/symfony-messenger
	dev-php/symfony-service-contracts"
BDEPEND="test? ( dev-php/doctrine-persistence
		dev-php/phpunit
		dev-php/symfony-property-access
		dev-php/symfony-serializer )"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
}

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Component/Messenger/Bridge/Doctrine
	doins -r Transport ./*.php
}
