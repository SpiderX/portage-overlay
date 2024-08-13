# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="The PHP Unit Testing framework"
HOMEPAGE="https://github.com/sebastianbergmann/phpunit"
SRC_URI="https://github.com/sebastianbergmann/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*[xmlwriter,unicode]
	dev-php/fedora-autoloader
	dev-php/myclabs-deepcopy
	dev-php/phar-io-manifest
	dev-php/phar-io-version
	dev-php/phpunit-php-code-coverage
	dev-php/phpunit-php-file-iterator
	dev-php/phpunit-php-invoker
	dev-php/phpunit-php-text-template
	dev-php/phpunit-php-timer
	dev-php/sebastian-cli-parser
	dev-php/sebastian-code-unit
	dev-php/sebastian-comparator
	dev-php/sebastian-diff
	dev-php/sebastian-environment
	dev-php/sebastian-exporter
	dev-php/sebastian-global-state
	dev-php/sebastian-object-enumerator
	dev-php/sebastian-recursion-context
	dev-php/sebastian-type
	dev-php/sebastian-version"
BDEPEND=">=dev-php/theseer-Autoload-1.29.1"

DOCS=( {ChangeLog-10.5,DEPRECATIONS,README}.md )

src_prepare() {
	default

	# search for schema in PHPUnit directory
	sed -i '/return __DIR__/s|/../../../../|/../../../|' \
		src/TextUI/Configuration/Xml/SchemaFinder.php \
		|| die "sed failed for SchemaFinder.php"
	mkdir src/vendor || die "mkdir failed"
	phpab --quiet --output src/vendor/autoload.php \
		--template fedora2 --basedir src/vendor/ src \
		|| die "phpab failed"
	install -D -m 644 "${FILESDIR}"/autoload.php \
		vendor/autoload.php || die "install failed"
	# add dependencies to autoload
	eapply "${FILESDIR}/${PN}"-10.5.27-autoload.patch
}

src_test() {
	# get tests
	composer require -d "${T}" --prefer-source \
		--dev "${PN}/${PN}:${PV}" || die "composer failed"
	# move tests into work dir
	cp -r "${T}/vendor/${PN}/${PN}"/{phpunit.xml,tests} "${S}" \
		|| die "cp tests failed"
	# remove failed tests
	sed -i '/testIsInitialized/,+17d' tests/unit/Util/ExcludeListTest.php \
		|| die "sed failed for ExcludeListTest.php"
	# generate autoload for unit
	phpab -q -o tests/unit/autoload.php -t fedora2 tests/unit/ \
		|| die "phpab tests unit failed"
	# generate autoload for fixtures
	phpab -q -o tests/_files/autoload.php -t fedora2 tests/_files/ \
		|| die "phpab tests files failed"
	phpab -o tests/end-to-end/execution-order/_files/autoload.php \
		-t fedora2 tests/end-to-end/execution-order/_files/ \
		|| die "phpab tests end-to-end failed"
	phpunit --testsuite unit || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/PHPUnit
	doins -r schema phpunit.xsd src/.

	exeinto /usr/share/php/PHPUnit
	doexe phpunit
	dosym ../share/php/PHPUnit/phpunit /usr/bin/phpunit
}
