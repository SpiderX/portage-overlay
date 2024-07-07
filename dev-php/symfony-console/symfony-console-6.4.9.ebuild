# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//symfony-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Eases the creation of beautiful and testable command line interfaces"
HOMEPAGE="https://github.com/symfony/console"
SRC_URI="https://github.com/symfony/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/symfony-deprecation-contracts
	dev-php/symfony-polyfill-mbstring
	dev-php/symfony-service-contracts
	dev-php/symfony-string"
BDEPEND="dev-php/theseer-Autoload"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	phpab --quiet --output autoload.php \
		--template fedora2 --basedir . . \
		|| die "phpab failed"

	eapply "${FILESDIR}/${PN}"-6.4.9-autoload.patch
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Component/Console
	doins -r Attribute CI Command CommandLoader Completion DataCollector \
		Debug DependencyInjection Descriptor Event EventListener \
		Exception Formatter Helper Input Logger Messenger Output \
		Question Resources SignalRegistry Style Tester *.php
}
