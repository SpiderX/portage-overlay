# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/amphp/file.git"

inherit git-r3 optfeature

DESCRIPTION="An abstraction layer and non-blocking file access solution"
HOMEPAGE="https://github.com/amphp/file"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

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
		>=dev-php/pecl-parallel-1.2.3
		dev-php/pecl-uv
		dev-php/phpunit )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
	composer require -d "${T}" --prefer-source \
		--dev "${PN/-/\/}:${PV}" || die "composer failed"
	mkdir -p vendor/amphp/{cache,sync} || die "mkdir failed"
	ln -s ../../../../../temp/vendor/amphp/cache/test \
		vendor/amphp/cache || die "ln failed for cache"
	ln -s ../../../../../temp/vendor/amphp/sync/test \
		vendor/amphp/sync || die "ln failed for sync"
	# fix abstract class with Test suffix
	mv test/FileTest{,Abstract}.php || die "mv failed for FileTest"
	sed -i '/class/s|FileTest|FileTestAbstract|' test/FileTestAbstract.php \
		|| die "sed failed for FileTestAbstract.php"
	sed -i -r '/[class|use] /s/(\\|\ )FileTest/\1FileTestAbstract/' \
		test/Driver/{Blocking,StatusCaching}FileTest.php \
		test/AsyncFileTest.php || die "sed failed for FileTest"
	mv test/AsyncFileTest{,Abstract}.php || die "mv failed for AsyncFileTest"
	sed -i '/[class|use] /s|AsyncFileTest|AsyncFileTestAbstract|' \
		test/Driver/{Eio,Parallel,Uv}FileTest.php \
		test/AsyncFileTestAbstract.php || die "sed failed for AsyncFileTest"
	mv test/FilesystemDriverTest{,Abstract}.php || die "mv failed for FilesystemDriverTest"
	sed -i '/class/s|FilesystemDriverTest|FilesystemDriverTestAbstract|' \
		test/FilesystemDriverTestAbstract.php || "sed failed for FilesystemDriverTestAbstract.php"
	sed -i -r '/[class|use] /s/(\\|\ )FilesystemDriverTest/\1FilesystemDriverTestAbstract/' \
		test/Driver/{Blocking,Eio,Parallel,StatusCaching,Uv}FilesystemDriverTest.php \
		|| die "sed failed for FilesystemDriverTest"
	mv test/FilesystemTest{,Abstract}.php || die "mv failed for FilesystemTest"
	sed -i '/class /s|FilesystemTest|FilesystemTestAbstract|' \
		test/File{,system,systemDriver}TestAbstract.php || die "sed failed for FilesystemTest"
}

src_test() {
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
