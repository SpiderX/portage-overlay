# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Extensions to the PHP Reflection API"
HOMEPAGE="https://github.com/laminas/laminas-code"
SRC_URI="https://github.com/laminas/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*[phar]
	dev-php/fedora-autoloader"
BDEPEND="test? ( dev-php/composer
		dev-php/doctrine-annotations
		dev-php/laminas-stdlib
		dev-php/phpunit )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
}

src_test() {
	composer require -d "${T}" --prefer-source \
		--dev laminas/"${PN}:${PV}" || die "composer failed"
	cp -r "${T}"/vendor/laminas/"${PN}"/{phpunit.xml.dist,test} "${S}" \
		|| die "cp failed"
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Laminas/Code
	doins -r src/.
}
