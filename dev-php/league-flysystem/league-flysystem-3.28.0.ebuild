# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//league-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Abstraction for local and remote filesystems"
HOMEPAGE="https://github.com/thephpleague/flysystem"
SRC_URI="https://github.com/thephpleague/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="fileinfo ftp test zip"
#REQUIRED_USE="test? ( fileinfo ftp zip )"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*[fileinfo?,ftp?,zip?]
	dev-php/fedora-autoloader
	dev-php/league-flysystem-local
	dev-php/league-mime-type-detection"
BDEPEND="test? ( dev-php/composer
		dev-php/guzzlehttp-psr7
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
	cp -r "${T}"/vendor/"${PN/-/\/}"/{phpunit.xml.dist,phpunit.php,test_files,mocked-functions.php} "${S}" \
		|| die "cp failed"
	cp -r "${T}"/vendor/"${PN/-/\/}"/src/{AdapterTestUtilities,InMemory,*Test.php} "${S}"/src \
		|| die "cp failed for src"
	phpunit --testdox || die "phpunit failed"
	# clean up test files before install
	rm -rf src/{AdapterTestUtilities,InMemory,*Test.php} || die "rm failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/League/Flysystem
	doins -r src/.
}
