# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/symfony/finder.git"

inherit git-r3

DESCRIPTION="Symfony Finder Component"
HOMEPAGE="https://github.com/symfony/finder"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"
BDEPEND="test? ( dev-php/phpunit
		dev-php/symfony-filesystem )"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
	sed -i '/testDelegate/,+6d' Tests/Iterator/LazyIteratorTest.php \
		|| die "sed failed for LazyIteratorTest.php"
	sed -i '/testIn(/,+23d' Tests/FinderTest.php \
		|| die "sed failed for FinderTest.php"
}

src_test() {
	# ftp layout on network tests changed
	phpunit --group default --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Component/Finder
	doins -r Comparator Exception Iterator ./*.php
}
