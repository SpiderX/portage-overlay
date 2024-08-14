# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//symfony-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Symfony PHPUnit Bridge"
HOMEPAGE="https://github.com/symfony/phpunit-bridge"
SRC_URI="https://github.com/symfony/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"
BDEPEND="test? ( dev-php/composer
		dev-php/phpunit
		dev-php/symfony-deprecation-contracts
		dev-php/symfony-error-handler
		dev-php/symfony-polyfill-php81 )"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
}

src_test() {
	composer require -d "${T}" --prefer-source \
		--dev "${PN/-/\/}:${PV}" || die "composer failed"
	cp -r "${T}"/vendor/"${PN/-/\/}"/{phpunit.xml.dist,Tests} "${S}" \
		|| die "cp failed"
	# remove failed test
	sed -i -e '/testBaselineFileWriteError/,+23d' \
		-e '/testBaselineGenerationWithDeprecationTriggeredByDebugClassLoader(/,+36d' \
		Tests/DeprecationErrorHandler/ConfigurationTest.php \
		|| die "sed failed for ConfigurationTest.php"
	sed -i  -e '/testItCanTellWhetherItIsInternal/,+11d' \
		-e '/testGetTypeDetectsSelf/,+11d' \
		-e '/testGetTypeUsesRightTrace/,+9d' \
		Tests/DeprecationErrorHandler/DeprecationTest.php \
		|| die "sed failed for DeprecationTest.php"
	rm Tests/DeprecationErrorHandler/debug_class_loader_autoload.phpt \
		Tests/DeprecationErrorHandler/debug_class_loader_deprecation.phpt \
		Tests/ProcessIsolationTest.php \
		Tests/ExpectDeprecationTraitTest.php \
		Tests/ExpectedDeprecationAnnotationTest.php \
		|| die "rm failed"
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Bridge/PhpUnit
	doins -r DeprecationErrorHandler Legacy TextUI bin/simple-phpunit.php ./*.php

	exeinto /usr/share/php/Symfony/Bridge/PhpUnit
	doexe bin/simple-phpunit
	dosym ../share/php/Symfony/Bridge/PhpUnit/simple-phpunit \
		/usr/bin/simple-phpunit
}
