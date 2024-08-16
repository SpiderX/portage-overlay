# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Flexible and feature-complete Redis client for PHP"
HOMEPAGE="https://github.com/predis/predis"
SRC_URI="https://github.com/predis/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no support of phpunit 10

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"

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
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Predis
	doins -r src/.
}
