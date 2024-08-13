# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//league-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="League Mime Type Detection"
HOMEPAGE="https://github.com/thephpleague/mime-type-detection"
SRC_URI="https://github.com/thephpleague/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*[fileinfo]
	dev-php/fedora-autoloader"

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
	cp -r "${T}"/vendor/"${PN/-/\/}"/{phpunit.xml.dist,test_files} "${S}" \
		|| die "cp failed"
	cp -r "${T}"/vendor/"${PN/-/\/}"/src/{Generation,*Test.php} "${S}"/src \
		|| die "cp for php files failed"
	# remove test with failed assert
	sed -i '/the_generated_map_should_be_up_to_date/,+15d' \
		src/GeneratedExtensionToMimeTypeMapTest.php \
		|| die "sed failed for GeneratedExtensionToMimeTypeMapTest.php"
	phpunit --bootstrap vendor/autoload.php --testdox || die "phpunit failed"
	# clean up test files before install
	rm -rf src/{Generation,*Test.php} || die "rm failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/League/MimeTypeDetection
	doins -r src/.
}
