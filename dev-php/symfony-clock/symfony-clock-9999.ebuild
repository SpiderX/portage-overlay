# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/symfony/clock.git"

inherit git-r3

DESCRIPTION="Symfony Clock Component"
HOMEPAGE="https://github.com/symfony/clock"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/psr-clock
	dev-php/symfony-polyfill-php83"
BDEPEND="test? ( dev-php/doctrine-dbal
		dev-php/phpunit
		dev-php/predis )"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
	sed -i '/Resources/d' autoload.php || die "sed failed for autoload.php"
	sed -i  -e "/]);/i\\\t'/usr/share/php/Doctrine/DBAL/autoload.php'," \
		-e "/]);/i\\\t'/usr/share/php/Predis/autoload.php'," \
		-e "/]);/i\\\t'/usr/share/php/Symfony/Component/Lock/autoload.php'," \
		vendor/autoload.php || die "sed failed for vendor/autoload.php"
}

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Component/Clock
	doins -r Resources Test ./*.php
}
