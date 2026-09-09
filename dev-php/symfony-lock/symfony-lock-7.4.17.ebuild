# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMPOSER_INSTALL_PATH="Symfony/Component/Lock"
COMPOSER_INSTALL_SRC="."
POSTGRES_COMPAT=( {14..18} )

inherit composer edo postgres

DESCRIPTION="Symfony Lock Component"
HOMEPAGE="https://github.com/symfony/lock"
SRC_URI="https://github.com/symfony/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/psr-log"
BDEPEND="test? ( ${POSTGRES_DEP}
		dev-db/redis
		dev-php/doctrine-dbal
		dev-php/doctrine-deprecations
		dev-php/predis
		dev-php/symfony-phpunit-bridge
		dev-php/symfony-serializer
		dev-php/relay )"

DOCS=( {CHANGELOG,README}.md )

# transient tests are timing-sensitive and unreliable when run with the full test suite
EPHPUNIT_EXCLUDE_GROUP=( transient )
composer_enable_tests phpunit

src_test() {
	composer_prepare_tests
	sed -i 's/ ignoreUndefinedTriggers="true"//' phpunit.xml.dist || die "sed failed for phpunit.xml.dist"
	edo "${EPREFIX}"/usr/sbin/redis-server - <<-EOF
	daemonize yes
	pidfile "${T}/redis-6379.pid"
	port 6379
	bind 127.0.0.1
	EOF
	export POSTGRES_HOST="127.0.0.1"  PGPASSWORD='password'
	local db="${T}/pgsql"
	edo initdb -U postgres -A trust -D "${db}"
	edo pg_ctl -w -D "${db}" start -o "-h '127.0.0.1' -p 5432 -k '${T}'"
	ephpunit
	edo pg_ctl -w -D "${db}" stop
	edo kill "$(<"${T}/redis-6379.pid")"
}
