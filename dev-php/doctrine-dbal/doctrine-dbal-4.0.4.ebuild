# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature

MY_PN="${PN//doctrine-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Doctrine Database Abstraction Layer"
HOMEPAGE="https://github.com/doctrine/dbal"
SRC_URI="https://github.com/doctrine/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mysql postgres sqlite test"
REQUIRED_USE="test? ( mysql postgres sqlite )"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*[pdo,mysql?,postgres?,sqlite?]
	dev-php/doctrine-deprecations
	dev-php/fedora-autoloader
	dev-php/psr-cache
	dev-php/psr-log"
BDEPEND="test? ( dev-php/composer
		dev-php/phpunit
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
	composer require -d "${T}" --prefer-source \
		--dev "${PN/-/\/}:${PV}" || die "composer failed"
	cp -r "${T}"/vendor/"${PN/-/\/}"/{phpunit.xml.dist,tests} "${S}" \
		|| die "cp failed"
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
