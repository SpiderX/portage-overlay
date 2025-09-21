# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//phpunit-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Library to invoke PHP callables with a timeout"
HOMEPAGE="https://github.com/sebastianbergmann/php-invoker"
SRC_URI="https://github.com/sebastianbergmann/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="pcntl test"
REQUIRED_USE="test? ( pcntl )"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*[pcntl?]
	dev-php/fedora-autoloader"
BDEPEND="dev-php/theseer-Autoload
	test? ( dev-php/composer
		dev-php/phpunit )"

DOCS=( {ChangeLog,README}.md )

src_prepare() {
	default

	phpab -q -o src/autoload.php -t fedora2 src || die "phpab failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install failed"
}

src_test() {
	composer require -d "${T}" --prefer-source \
		--dev "${PN/-/\/}:${PV}" || die "composer failed"
	cp -r "${T}"/vendor/"${PN/-/\/}"/{phpunit.xml,tests} "${S}" \
		|| die "cp failed"
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/SebastianBergmann/Invoker
	doins -r src/.
}
