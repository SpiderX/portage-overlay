# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Symfony Config Component"
HOMEPAGE="https://github.com/symfony/config"
EGIT_REPO_URI="https://github.com/symfony/config.git"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/symfony-deprecation-contracts
	>=dev-php/symfony-filesystem-6
	dev-php/symfony-polyfill-ctype"
# test needs class from composer
BDEPEND="test? ( dev-php/composer
		dev-php/phpunit
		dev-php/symfony-event-dispatcher
		>=dev-php/symfony-finder-6
		dev-php/symfony-messenger
		dev-php/symfony-service-contracts
		dev-php/symfony-yaml )"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
	eapply "${FILESDIR}/${PN}"-7.3.2-test-composer-version.patch
	# remove composer specific test
	sed -i '/testGetVendor/,+16d' Tests/Resource/ComposerResourceTest.php \
		|| die "sed failed for ComposerResourceTest.php"
}

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Component/Config
	doins -r Builder Definition Exception Loader Resource Util ./*.php
}
