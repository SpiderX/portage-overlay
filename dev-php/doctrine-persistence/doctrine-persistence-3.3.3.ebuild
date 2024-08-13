# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//doctrine-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Doctrine Persistence"
HOMEPAGE="https://github.com/doctrine/persistence"
SRC_URI="https://github.com/doctrine/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*
	dev-php/doctrine-event-manager
	dev-php/fedora-autoloader
	dev-php/psr-cache"
BDEPEND="test? ( dev-php/composer
		dev-php/doctrine-common
		dev-php/phpunit
		dev-php/symfony-cache )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/Persistence/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
}

src_test() {
	composer require -d "${T}" --prefer-source \
		--dev "${PN/-/\/}:${PV}" || die "composer failed"
	cp -r "${T}"/vendor/"${PN/-/\/}"/{phpunit.xml.dist,tests,tests_php74,tests_php81} "${S}" \
		|| die "cp failed"
	# remove test uses deprecated method withConsecutive
	sed -i '/testItSkipsTransientClasses/,+24d' \
	tests/Persistence/Mapping/AbstractClassMetadataFactoryTest.php \
	|| die "sed failed for AbstractClassMetadataFactoryTest.php"
	phpunit --bootstrap vendor/autoload.php --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Doctrine
	doins -r src/.
}
