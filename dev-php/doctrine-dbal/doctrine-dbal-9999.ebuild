# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/doctrine/dbal.git"

inherit git-r3 optfeature

DESCRIPTION="Doctrine Database Abstraction Layer"
HOMEPAGE="https://github.com/doctrine/dbal"

LICENSE="MIT"
SLOT="0"
IUSE="mysql postgres sqlite test"
REQUIRED_USE="test? ( mysql postgres sqlite )"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*[pdo,mysql?,postgres?,sqlite?]
	dev-php/doctrine-deprecations
	dev-php/fedora-autoloader
	dev-php/psr-cache
	dev-php/psr-log"
BDEPEND="test? ( dev-php/phpunit
		dev-php/symfony-cache
		dev-php/symfony-console )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
}

src_test() {
	phpunit --bootstrap vendor/autoload.php --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Doctrine/DBAL
	doins -r src/.
}

pkg_postinst() {
	optfeature "Support of helpful console commands such as SQL execution" dev-php/symfony-console
}
