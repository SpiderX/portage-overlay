# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/thephpleague/html-to-markdown.git"

inherit git-r3

DESCRIPTION="HTML To Markdown for PHP"
HOMEPAGE="https://github.com/thephpleague/html-to-markdown"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*[xml]
	dev-php/fedora-autoloader"
BDEPEND="test? ( dev-php/composer
		dev-php/mikehaertl-php-shellcommand
		dev-php/phpunit )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
	sed -i  -e '/backupStaticAttributes/d' -e '/verbose/d' \
		-e '/convertErrorsToExceptions/d' -e '/convertNoticesToExceptions/d' \
		-e '/convertWarningsToExceptions/d' -e '/<filter/,+4d' -e '/logging/,+6d' \
		phpunit.xml.dist || die "sed failed for phpunit.xml.dist"
}

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/League/HTMLToMarkdown
	doins -r bin src/.

	exeinto /usr/share/php/League/HTMLToMarkdown
	doexe bin/html-to-markdown
	dosym ../share/php/League/HTMLToMarkdown/html-to-markdown \
		/usr/bin/html-to-markdown
}
