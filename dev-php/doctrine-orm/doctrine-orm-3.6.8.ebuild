# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMPOSER_INSTALL_PATH="Doctrine/ORM"
PHP_REQ_USE="ctype,mysql?,mssql?,postgres?,sqlite?"

inherit composer edo optfeature

DESCRIPTION="Doctrine Object Relational Mapper"
HOMEPAGE="https://github.com/doctrine/orm"
SRC_URI="https://github.com/doctrine/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="mysql mssql postgres sqlite"
REQUIRED_USE="test? ( mysql mssql postgres sqlite )"

RDEPEND="dev-php/composer
	dev-php/doctrine-collections
	dev-php/doctrine-dbal
	dev-php/doctrine-deprecations
	dev-php/doctrine-event-manager
	dev-php/doctrine-inflector
	>=dev-php/doctrine-instantiator-2
	dev-php/doctrine-lexer
	dev-php/doctrine-persistence
	dev-php/psr-cache
	dev-php/symfony-console
	dev-php/symfony-var-exporter"
BDEPEND="test? ( dev-db/redis
		dev-php/symfony-cache )"

COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-3.6.7-tests-GH9230Test.patch
	"${FILESDIR}/${PN}"-3.6.7-tests-SingleScalarHydratorTest.patch )
composer_enable_tests phpunit

src_test() {
	composer_prepare_tests
	edo "${EPREFIX}"/usr/sbin/redis-server - <<- EOF
		daemonize yes
		pidfile "${T}/redis.pid"
		port 6379
		bind 127.0.0.1
	EOF
	REDIS_HOST=127.0.0.1 ephpunit
	edo kill "$(<"${T}/redis.pid")"
}

src_install() {
	composer_src_install

	insinto /usr/share/php/Doctrine
	doins doctrine-mapping.xsd
}

pkg_postinst() {
	optfeature "Cache support for Setup Tool" dev-php/symfony-cache
}
