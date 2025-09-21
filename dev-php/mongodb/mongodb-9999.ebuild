# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="The Official MongoDB PHP library"
HOMEPAGE="https://github.com/mongodb/mongo-php-library"
EGIT_REPO_URI="https://github.com/mongodb/mongo-php-library.git"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="test" # not ready for phpunit 10

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/jean85-pretty-package-versions
	>=dev-php/pecl-mongodb-1.21.0
	dev-php/psr-log"
BDEPEND="test? ( dev-php/composer
		dev-php/phpunit )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
	# fix funciton declaration
	sed -i  -e '/function accepts/s|\$|mixed \$|g' \
		-e '/function accepts/s|$|: bool|' tests/Comparator/Int64Comparator.php \
		|| die "sed failed for Int64Comparator.php"
}

src_test() {
	mongod --port 27017 --bind_ip 127.0.0.1 --nounixsocket --fork \
		--dbpath="${T}" --logpath="${T}/mongod.log" || die "mondod failed"
	# php.ini must have zend.assertions = 1
	phpunit --testdox || die "phpunit failed"
	kill "$(<"${T}/mongod.lock")" || die "kill failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/MongoDB
	doins -r src/.
}
