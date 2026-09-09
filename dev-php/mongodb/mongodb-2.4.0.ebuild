# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="MongoDB"
COMPOSER_VENDOR="${PN%%-*}"
COMPOSER_PKG="${PN#*-}"
COMPOSER_PN="${COMPOSER_VENDOR}/${COMPOSER_PKG}"
COMPOSER_SRC="${T}/composer/${COMPOSER_PKG}"

inherit composer

SPEC_COMMIT="92b3c0b9287bfba1b0ec4084300858d05c654f8c"

DESCRIPTION="The Official MongoDB PHP library"
HOMEPAGE="https://github.com/mongodb/mongo-php-library"
SRC_URI="https://github.com/mongodb/mongo-php-library/archive/${PV}.tar.gz -> ${P}.tar.gz
	test? ( https://github.com/mongodb/specifications/archive/${SPEC_COMMIT}.tar.gz
		-> mongodb-specifications-${SPEC_COMMIT}.tar.gz )"
S="${WORKDIR}/mongo-php-library-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/jean85-pretty-package-versions
	>=dev-php/pecl-mongodb-${PV}
	dev-php/psr-log
	dev-php/symfony-polyfill-php85"

COMPOSER_TEST_FILES=( examples )
COMPOSER_TEST_PATCHES=( "${FILESDIR}/${PN}"-2.4.0-tests-BucketFunctionalTest.patch
	"${FILESDIR}/${PN}"-2.4.0-tests-CollectionFunctionalTest.patch
	"${FILESDIR}/${PN}"-2.4.0-tests-DocumentsMatchConstraintTest.patch
	"${FILESDIR}/${PN}"-2.4.0-tests-FieldPathTest.patch
	"${FILESDIR}/${PN}"-2.4.0-tests-GetEncryptedFieldsFromServerFunctionalTest.patch
	"${FILESDIR}/${PN}"-2.4.0-tests-Operation.patch )
composer_enable_tests phpunit

src_test() {
	composer_prepare_tests
	edo cp -r "${WORKDIR}/specifications-${SPEC_COMMIT}"/. tests/specifications
	# unified specification tests use MongoDB fail points to simulate command errors.
	# configureFailPoint is available only when test commands are enabled.
	# functional/spec test suite creates many MongoDB collections and indexes.
	# raise the file-descriptor limit with 'ulimit -n 65536' to prevent WiredTiger from aborting with EMFILE.
	edo mongod --port 27017 --bind_ip 127.0.0.1 --nounixsocket --setParameter enableTestCommands=1 --fork \
		--dbpath="${T}" --logpath="${T}/mongod.log"
	edo php -d zend.assertions=1 -d memory_limit=512M /usr/bin/phpunit --testdox
	edo kill "$(<"${T}/mongod.lock")"
}
