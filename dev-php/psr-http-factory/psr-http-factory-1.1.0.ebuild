# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//psr-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Implementation of PSR-17 (HTTP Message Factories)"
HOMEPAGE="https://github.com/php-fig/http-factory"
SRC_URI="https://github.com/php-fig/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/psr-http-message"

src_install() {
	einstalldocs
	insinto /usr/share/php/Psr/Http/Message
	doins -r src/.
	insinto /usr/share/php/Psr/Http/Message/Factory
	doins "${FILESDIR}"/autoload.php
}
