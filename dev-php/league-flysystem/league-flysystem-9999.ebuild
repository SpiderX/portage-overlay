# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/thephpleague/flysystem.git"

inherit git-r3

DESCRIPTION="Abstraction for local and remote filesystems"
HOMEPAGE="https://github.com/thephpleague/flysystem"

LICENSE="MIT"
SLOT="0"
IUSE="fileinfo ftp test zip"
REQUIRED_USE="test? ( fileinfo ftp zip )"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*[fileinfo?,ftp?,zip?]
	dev-php/fedora-autoloader
	dev-php/league-flysystem-local
	dev-php/league-mime-type-detection"
BDEPEND="test? ( dev-php/composer
		dev-php/guzzlehttp-psr7
		dev-php/mongodb
		dev-php/pecl-mongodb
		dev-php/phpunit )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
}

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/League/Flysystem
	doins -r src/.
}
