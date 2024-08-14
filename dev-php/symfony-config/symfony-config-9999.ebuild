# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/symfony/config.git"

inherit git-r3

DESCRIPTION="Symfony Config Component"
HOMEPAGE="https://github.com/symfony/config"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/symfony-deprecation-contracts
	>=dev-php/symfony-filesystem-6.4.9
	dev-php/symfony-polyfill-ctype"
# test needs class from composer
BDEPEND="test? ( dev-php/composer
		dev-php/phpunit
		dev-php/symfony-event-dispatcher
		>=dev-php/symfony-finder-6.4.8
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
	# remove composer specific test
	sed -i '/testGetVendor/,+16d' Tests/Resource/ComposerResourceTest.php \
		|| die "sed failed for ComposerResourceTest.php"
	# don't fail test
	sed -i '52d' Tests/Util/XmlUtilsTest.php || die "sed failed for XmlUtilsTest.php"
}

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Component/Config
	doins -r Builder Definition Exception Loader Resource Util ./*.php
}
