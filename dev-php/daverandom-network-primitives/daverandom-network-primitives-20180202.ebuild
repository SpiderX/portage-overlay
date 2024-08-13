# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="621fd76a2438294a46df81ada3355c95f690eedd"
MY_P="NetworkPrimitives-${COMMIT}"

DESCRIPTION="Primitive types for network programming in PHP"
HOMEPAGE="https://github.com/DaveRandom/NetworkPrimitives"
SRC_URI="https://github.com/DaveRandom/NetworkPrimitives/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*
	dev-php/daverandom-enum
	dev-php/fedora-autoloader"

src_install() {
	einstalldocs
	insinto /usr/share/php/DaveRandom/Network
	doins -r src/. "${FILESDIR}"/autoload.php
	insinto /usr/share/php/NetworkInterop
	doins -r interfaces/.
	newins "${FILESDIR}"/autoload-interfaces.php autoload.php
}
