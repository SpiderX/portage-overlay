# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Serialization tools for IPC and data storage in PHP"
HOMEPAGE="https://github.com/amphp/serialization"
EGIT_REPO_URI="https://github.com/amphp/serialization.git"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"
BDEPEND="test? ( dev-php/phpunit )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
	# fix non-static data provider deprecation
	sed -i '/provideSerializableData(/s|function|static function|g' \
		test/{Compressing,}JsonSerializerTest.php \
		|| die "sed failed for CompressingJsonSerializerTest.php"
	sed -i  -e '/provideSerializeData(/s|function|static function|' \
		-e '/provideLargeSerializeData(/s|function|static function|' \
		-e '/provideUnserializableData(/s|function|static function|' \
		-e '/provideInvalidData(/s|function|static function|' \
		test/{Compressing,}NativeSerializerTest.php \
		|| die "sed failed for CompressingNativeSerializerTest.php"
}

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Amp/Serialization
	doins -r src/.
}
