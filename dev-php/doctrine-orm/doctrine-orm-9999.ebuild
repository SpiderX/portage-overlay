# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/doctrine/orm.git"

inherit git-r3 optfeature

DESCRIPTION="Doctrine Object Relational Mapper"
HOMEPAGE="https://github.com/doctrine/orm"

LICENSE="MIT"
SLOT="0"
IUSE="mysql mssql postgres sqlite test"
REQUIRED_USE="test? ( mysql mssql postgres sqlite )"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*[ctype,mysql?,mssql?,postgres?,sqlite?]
	dev-php/fedora-autoloader
	dev-php/doctrine-collections
	dev-php/doctrine-dbal
	dev-php/doctrine-deprecations
	dev-php/doctrine-event-manager
	dev-php/doctrine-inflector
	dev-php/doctrine-instantiator
	dev-php/doctrine-lexer
	dev-php/doctrine-persistence
	dev-php/psr-cache
	dev-php/symfony-console
	dev-php/symfony-var-exporter"
BDEPEND="test? ( dev-php/pecl-apcu
		dev-php/phpunit
		dev-php/symfony-cache )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
	# remove composer specific test
	rm tests/Tests/ORM/Tools/Console/ConsoleRunnerTest.php \
		|| die "rm failed for ConsoleRunnerTest.php"
}

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Doctrine/ORM
	doins -r src/.

	insinto /usr/share/php/Doctrine
	doins doctrine-mapping.xsd
}

pkg_postinst() {
	optfeature "Cache support for Setup Tool" dev-php/symfony-cache
}
