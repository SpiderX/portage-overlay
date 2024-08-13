# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="html5-php"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="An HTML5 parser and serializer for PHP"
HOMEPAGE="https://github.com/Masterminds/html5-php"
SRC_URI="https://github.com/Masterminds/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*[xml]
	dev-php/fedora-autoloader"
BDEPEND="test? ( dev-php/composer
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
		--dev "${PN/-/\/}:${PV}" || die "composer failed"
	cp -r "${T}"/vendor/"${PN/-/\/}"/{phpunit.xml.dist,test} "${S}" \
		|| die "cp failed"
	# replace deprecated method
	sed -i 's/assertRegExp/assertMatchesRegularExpression/' \
		test/HTML5/{Html5Test,Serializer/OutputRulesTest}.php \
		|| die "sed failed"
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Masterminds
	doins -r src/.
}
