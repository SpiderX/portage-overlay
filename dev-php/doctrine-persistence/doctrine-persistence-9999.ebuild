# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/doctrine/persistence.git"

inherit git-r3

DESCRIPTION="Doctrine Persistence"
HOMEPAGE="https://github.com/doctrine/persistence"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/doctrine-event-manager
	dev-php/fedora-autoloader
	dev-php/psr-cache"
BDEPEND="test? ( dev-php/doctrine-common
		dev-php/phpunit
		dev-php/symfony-cache )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/Persistence/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
	# remove test uses deprecated method withConsecutive
	sed -i '/testItSkipsTransientClasses/,+24d' \
	tests/Persistence/Mapping/AbstractClassMetadataFactoryTest.php \
	|| die "sed failed for AbstractClassMetadataFactoryTest.php"
}

src_test() {
	phpunit --bootstrap vendor/autoload.php --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Doctrine
	doins -r src/.
}
