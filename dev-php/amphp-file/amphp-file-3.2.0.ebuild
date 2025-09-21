# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature

MY_PN="${PN//amphp-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="An abstraction layer and non-blocking file access solution"
HOMEPAGE="https://github.com/amphp/file"
SRC_URI="https://github.com/amphp/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="test" # not ready for phpunit 11

RDEPEND="dev-lang/php:*
	dev-php/amphp-amp
	dev-php/amphp-byte-stream
	dev-php/amphp-cache
	dev-php/amphp-parallel
	dev-php/amphp-sync
	dev-php/fedora-autoloader
	dev-php/revolt-event-loop"
BDEPEND="test? ( dev-php/composer
		dev-php/pecl-eio
		dev-php/pecl-uv
		dev-php/phpunit )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
}

src_test() {
	composer require -d "${T}" --prefer-source \
		--dev "${PN/-/\/}:${PV}" || die "composer failed"
	cp -r "${T}"/vendor/"${PN/-/\/}"/{phpunit.xml.dist,test} "${S}" \
		|| die "cp failed"
	mkdir -p vendor/amphp/{cache,sync} || die "mkdir failed"
	ln -s ../../../../../temp/vendor/amphp/cache/test \
		vendor/amphp/cache || die "ln failed for cache"
	ln -s ../../../../../temp/vendor/amphp/sync/test \
		vendor/amphp/sync || die "ln failed for sync"
	# fix non-static data provider deprecation
	sed -i  -e '/symlinkPathProvider(/s|function|static function|' \
		-e '/dataForDirectoryCheck(/s|function|static function|' \
		-e '/dataForFileCheck(/s|function|static function|' \
		-e '/dataForSymlinkCheck(/s|function|static function|' \
		test/FilesystemDriverTest.php \
		|| die "sed failed for CompliesTest.php"
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Amp/File
	doins -r src/.
}

pkg_postinst() {
	optfeature "PHP extention with eio" dev-php/pecl-eio
	optfeature "PHP extention with parallel" dev-php/pecl-parallel
	optfeature "PHP extention with uv" dev-php/pecl-uv
}
