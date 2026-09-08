# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMPOSER_INSTALL_PATH="Amp/File"

inherit composer edo optfeature

DESCRIPTION="An abstraction layer and non-blocking file access solution"
HOMEPAGE="https://github.com/amphp/file"
SRC_URI="https://github.com/amphp/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/amphp-amp
	dev-php/amphp-byte-stream
	dev-php/amphp-cache
	dev-php/amphp-parallel
	dev-php/amphp-sync
	dev-php/revolt-event-loop"
BDEPEND="test? ( dev-php/pecl-eio
		dev-php/pecl-uv )"

COMPOSER_TEST_PATCHES=(
	"${FILESDIR}/${PN}"-4.0.0-tests-FilesystemDriverTest.patch
	"${FILESDIR}/${PN}"-4.0.0-tests-FileTest.patch
	"${FILESDIR}/${PN}"-4.0.0-tests-ParallelFilesystemDriverTest.patch
	"${FILESDIR}/${PN}"-4.0.0-tests-ParallelFileTest.patch
	"${FILESDIR}/${PN}"-4.0.0-tests-UvFilesystemDriverTest.patch
	"${FILESDIR}/${PN}"-4.0.0-tests-phpunit.xml.patch )
composer_enable_tests phpunit

src_prepare() {
	composer_src_prepare

	# Amp\Parallel workers execute in separate PHP processes. They do not inherit the autoloaders
	# registered by the parent PHPUnit process. The worker bootstrap loads this package's test
	# autoloader inside each worker before serialized Amp\File\Internal\FileTask instances are
	# received. Without it, PHP unserializes those tasks as __PHP_Incomplete_Class and
	# Amp\Parallel reports that the Task class is not autoloadable.
	edo install -D -m 644 "${FILESDIR}"/worker-bootstrap.php .
}

src_test() {
	# obtain upstream dependency test fixtures which are not included in the release
	edo mkdir -p "${COMPOSER_SRC}"
	edo composer require -q --dev --prefer-source "${COMPOSER_PN}:${PV}" -d "${COMPOSER_SRC}"
	edo mkdir -p vendor/amphp/{cache,sync}
	edo ln -s ../../../../../temp/composer/file/vendor/amphp/cache/test vendor/amphp/cache
	edo ln -s ../../../../../temp/composer/file/vendor/amphp/sync/test vendor/amphp/sync
	composer_test_patch

	# Without ext-parallel, Amp\Parallel falls back to ProcessContext. Revolt's
	# UvDriver misses the readable notification for Amp\Process' POSIX exit-status
	# pipe on this setup, leaving Process::join() suspended. StreamSelectDriver
	# handles the process-worker lifecycle correctly.
	has_version dev-php/pecl-parallel || export REVOLT_DRIVER='Revolt\EventLoop\Driver\StreamSelectDriver'
	ephpunit
}

pkg_postinst() {
	optfeature "PHP extention with eio" dev-php/pecl-eio
	optfeature "PHP extention with parallel" dev-php/pecl-parallel
	optfeature "PHP extention with uv" dev-php/pecl-uv
}
