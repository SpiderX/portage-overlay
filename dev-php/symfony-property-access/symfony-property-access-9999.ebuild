# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Symfony PropertyAccess Component"
HOMEPAGE="https://github.com/symfony/property-access"
EGIT_REPO_URI="https://github.com/symfony/property-access.git"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/symfony-deprecation-contracts
	dev-php/symfony-property-info"
BDEPEND="test? ( dev-php/phpunit
		dev-php/symfony-cache )"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
}

src_test() {
	# skipped — testIs{Writable,Readable,SetValue}WithAsymmetricVisibility
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Component/PropertyAccess
	doins -r Exception ./*.php
}
