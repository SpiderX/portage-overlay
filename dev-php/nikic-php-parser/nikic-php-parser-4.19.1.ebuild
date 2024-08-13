# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="PHP-Parser"

DESCRIPTION="A PHP parser written in PHP"
HOMEPAGE="https://github.com/nikic/PHP-Parser"
SRC_URI="https://github.com/nikic/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*[tokenizer]
	dev-php/fedora-autoloader"
BDEPEND="test? ( dev-php/composer
		dev-php/phpunit )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		lib/PhpParser/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
}

src_test() {
	composer require -d "${T}" --prefer-source \
		--dev "${PN/-/\/}:${PV}" || die "composer failed"
	cp -r "${T}"/vendor/"${PN/-/\/}"/{phpunit.xml.dist,test} "${S}" \
		|| die "cp tests failed"
	eapply "${FILESDIR}/${PN}"-4.19.1-NodeAbstractTest.patch
	eapply "${FILESDIR}/${PN}"-4.19.1-ParserTestAbstract.patch
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/nikic
	doins -r lib/.
}
