# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Tools to manage errors and ease debugging PHP code"
HOMEPAGE="https://github.com/symfony/error-handler"
EGIT_REPO_URI="https://github.com/symfony/error-handler.git"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/psr-log
	dev-php/symfony-var-dumper"
BDEPEND="test? ( dev-php/phpunit )"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
}

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Component/ErrorHandler
	doins -r Command Error ErrorEnhancer ErrorRenderer Exception \
		Internal Resources ./*.php
}
