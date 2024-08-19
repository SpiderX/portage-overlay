# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/sebastianbergmann/${PN}.git"

inherit git-r3 optfeature

DESCRIPTION="The PHP Unit Testing framework"
HOMEPAGE="https://github.com/sebastianbergmann/phpunit"

LICENSE="BSD"
SLOT="0"
IUSE="soap test"
REQUIRED_USE="test? ( soap )"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*[soap?,xml,xmlwriter,unicode]
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
	>=dev-php/sebastian-diff-5.1.1
	dev-php/sebastian-environment
	dev-php/sebastian-exporter
	dev-php/sebastian-global-state
	dev-php/sebastian-object-enumerator
	dev-php/sebastian-recursion-context
	dev-php/sebastian-type
	dev-php/sebastian-version"
BDEPEND=">=dev-php/theseer-Autoload-1.29.1"

PATCHES=( "${FILESDIR}/${PN}"-10.5.27-autoload-resources.patch
	"${FILESDIR}/${PN}"-10.5.27-tests.patch )

DOCS=( {ChangeLog-10.5,DEPRECATIONS,README}.md )

src_prepare() {
	default

	phpab -q -o src/autoload.php -t "${FILESDIR}"/autoload.php.tpl \
		src || die "phpab failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install failed"
	# generate autoload for unit
	phpab -q -o tests/unit/autoload.php -t fedora2 tests/unit/ \
		|| die "phpab tests unit failed"
	# generate autoload for fixtures
	phpab -q -o tests/_files/autoload.php -t fedora2 tests/_files/ \
		|| die "phpab tests files failed"
	# generate autoloads for end-to-end
	phpab -o tests/end-to-end/execution-order/_files/autoload.php \
		-t fedora2 tests/end-to-end/execution-order/_files/ \
		|| die "phpab tests execution order failed"
	phpab -o tests/end-to-end/event/autoload.php -t fedora2 \
		tests/end-to-end/event || die "phpab tests event failed"
	phpab -o tests/end-to-end/regression/autoload.php -t fedora2 \
		-e tests/end-to-end/regression/4376/tests/Test.php \
		tests/end-to-end/regression || die "phpab tests regression failed"
	phpab -o tests/end-to-end/testdox/autoload.php -t fedora2 \
		tests/end-to-end/testdox || die "phpab tests testdox failed"
}

src_test() {
	# paths need to be fixed to run end-to-end
	phpunit --testsuite unit || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/PHPUnit
	doins -r schema phpunit.xsd src/.
	dobin phpunit
}

pkg_postinst() {
	optfeature "Support to generate mocks based on WSDL files" dev-lang/php[soap]
}
