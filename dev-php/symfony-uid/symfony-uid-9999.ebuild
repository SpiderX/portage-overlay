# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/symfony/uid.git"

inherit git-r3 optfeature

DESCRIPTION="Object-oriented API to generate and represent UIDs"
HOMEPAGE="https://github.com/symfony/uid"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/symfony-polyfill-uuid"
BDEPEND="test? ( dev-php/phpunit
		dev-php/symfony-console )"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
}

src_test() {
	# don't run time-sensitive
	phpunit --exclude-group time-sensitive --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Component/Uid
	doins -r Command Factory ./*.php
}

pkg_postinst() {
	optfeature "PHP extention with uuid" dev-php/pecl-uuid
}
