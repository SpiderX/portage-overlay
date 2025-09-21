# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//symfony-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Symfony Doctrine Messenger"
HOMEPAGE="https://github.com/symfony/doctrine-messenger"
SRC_URI="https://github.com/symfony/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*
	dev-php/doctrine-dbal
	dev-php/fedora-autoloader
	dev-php/symfony-messenger
	dev-php/symfony-service-contracts"
BDEPEND="test? ( dev-php/composer
		dev-php/doctrine-persistence
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
	composer require -d "${T}" --prefer-source \
		--dev "${PN/-/\/}:${PV}" || die "composer failed"
	cp -r "${T}"/vendor/"${PN/-/\/}"/{phpunit.xml.dist,Tests} "${S}" \
		|| die "cp failed"
	# remove integration tests need postgresql, pgbouncer
	rm Tests/Transport/DoctrinePostgreSql{,Filter,Pgbouncer,Regular}IntegrationTest.php \
		|| die "rm failed"
	# skipped — testGetWithSkipLockedWithoutForUpdateMethod
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Component/Messenger/Bridge/Doctrine
	doins -r Transport ./*.php
}
