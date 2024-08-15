# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/laminas/laminas-stdlib.git"

inherit git-r3

DESCRIPTION="PSR HTTP Message implementations"
HOMEPAGE="https://github.com/laminas/laminas-diactoros"

LICENSE="BSD"
SLOT="0"
IUSE="curl gd ipv6 test xml"
REQUIRED_USE="test? ( curl gd xml )"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*[curl?,gd?,ipv6?,xml?]
	dev-php/fedora-autoloader
	dev-php/psr-http-factory
	dev-php/psr-http-message"
BDEPEND="test? ( dev-php/http-interop-http-factory-tests
		dev-php/phpunit
		dev-php/php-http-psr7-integration-tests )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
	mkdir -p vendor/http-interop/http-factory-tests || die "mkdir failed"
	ln -s ../../../../../../../../../../usr/share/php/Interop/Http/Factory/ \
		vendor/http-interop/http-factory-tests/test \
		|| die "ln failed"
	! use ipv6 && eapply "${FILESDIR}/${PN}"-3.3.1-test-no-ipv6.patch
	# replace deprecated method
	sed -i 's/setMethods/onlyMethods/' test/StreamTest.php || die "sed failed"
	# replace exception
	sed -i '502s/Runtime/InvalidArgument/' test/StreamTest.php
	# fix test does not extend TestCase
	mv test/TestAsset/CallbacksForCallbackStream{Test,}.php || die "mv failed"
	sed -i '/class /s|Test||' test/TestAsset/CallbacksForCallbackStream.php \
		|| die "sed failed for CallbacksForCallbackStream.php"
	sed -i '/CallbacksForCallback/s|StreamTest|Stream|' test/CallbackStreamTest.php \
		|| die "sed faled for CallbackStreamTest.php"
	# do not test stream factory till https://github.com/laminas/laminas-diactoros/pull/190
	sed -i '/STREAM_FACTORY/d' phpunit.xml.dist || die "sed failed for phpunit.xml.dist"
}

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Laminas/Diactoros
	doins -r src/.
}
