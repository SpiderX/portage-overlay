# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Flexible and feature-complete Redis client for PHP"
HOMEPAGE="https://github.com/predis/predis"
SRC_URI="https://github.com/predis/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"
BDEPEND="dev-php/theseer-Autoload"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
}

src_test() {
	composer require -d "${T}" --prefer-source \
		--dev "${PN}/${PN}:${PV}" || die "composer failed"
	cp -r "${T}/vendor/${PN}/${PN}"/{phpunit.xml.dist,tests} "${S}" \
		|| die "cp tests failed"
	# generate autoload for unit
#	phpab -q -o tests/unit/autoload.php -t fedora2 tests/unit/ \
#		|| die "phpab tests unit failed"
#	# generate autoload for fixtures
#	phpab -q -o tests/_files/autoload.php -t fedora2 tests/_files/ \
#		|| die "phpab tests files failed"
#	phpab -o tests/end-to-end/execution-order/_files/autoload.php \
#		-t fedora2 tests/end-to-end/execution-order/_files/ \
#		|| die "phpab tests end-to-end failed"
	phpunit --testsuite unit || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Predis
	doins -r src/.
}
