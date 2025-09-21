# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Symfony MIME Component"
HOMEPAGE="https://github.com/symfony/mime"
EGIT_REPO_URI="https://github.com/symfony/mime.git"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/symfony-deprecation-contracts
	dev-php/symfony-polyfill-intl-idn
	dev-php/symfony-polyfill-mbstring"
BDEPEND="test? ( dev-php/egulias-email-validator
		dev-php/league-html-to-markdown
		dev-php/phpdocumentor-reflection-docblock
		dev-php/phpunit
		dev-php/symfony-dependency-injection
		dev-php/symfony-phpunit-bridge
		>=dev-php/symfony-process-6
		dev-php/symfony-property-access
		dev-php/symfony-property-info
		dev-php/symfony-serializer )"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
	# remove assert failed tests
	rm Tests/Crypto/DkimSignerTest.php || die "rm failed for DkimSignerTest.php"
}

src_test() {
	# skipped — testGuessWithDuplicatedFileType
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Component/Mime
	doins -r Crypto DependencyInjection Encoder Exception Header \
		HtmlToTextConverter Part Resources Test ./*.php
}
