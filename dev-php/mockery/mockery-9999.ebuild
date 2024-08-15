# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/mockery/mockery.git"

inherit git-r3

DESCRIPTION="Flexible PHP mock object framework"
HOMEPAGE="https://github.com/mockery/mockery"

LICENSE="BSD"
SLOT="0"
IUSE="test"
RESTRICT="test" # https://github.com/mockery/mockery/pull/1219/commits

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/hamcrest"
BDEPEND="test? ( dev-php/composer
		dev-php/phpunit )"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		library/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
}

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Mockery
	doins -r library/Mockery/. library/{autoload,helpers,Mockery}.php
}
