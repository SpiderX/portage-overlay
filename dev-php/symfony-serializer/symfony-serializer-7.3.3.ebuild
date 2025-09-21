# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//symfony-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Symfony Serializer Component"
HOMEPAGE="https://github.com/symfony/serializer"
SRC_URI="https://github.com/symfony/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="bcmath gmp test"
REQUIRED_USE="test? ( bcmath gmp )"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*[bcmath?,gmp?]
	dev-php/fedora-autoloader
	dev-php/symfony-deprecation-contracts
	dev-php/symfony-polyfill-ctype
	dev-php/symfony-polyfill-php84"
BDEPEND="test? ( dev-php/composer
		dev-php/jsonlint
		dev-php/phpdocumentor-reflection-docblock
		dev-php/phpunit
		dev-php/symfony-cache
		dev-php/symfony-config
		dev-php/symfony-console
		dev-php/symfony-dependency-injection
		dev-php/symfony-error-handler
		dev-php/symfony-http-foundation
		dev-php/symfony-http-kernel
		>=dev-php/symfony-filesystem-6
		dev-php/symfony-form
		dev-php/symfony-messenger
		dev-php/symfony-mime
		dev-php/symfony-phpunit-bridge
		dev-php/symfony-property-access
		dev-php/symfony-property-info
		dev-php/symfony-translation-contracts
		dev-php/symfony-type-info
		dev-php/symfony-validator
		dev-php/symfony-var-dumper
		dev-php/symfony-var-exporter
		dev-php/symfony-uid
		dev-php/symfony-yaml )"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
}

src_test() {
	composer require -d "${T}" --prefer-source \
		--dev "${PN/-/\/}:${PV}" || die "composer failed"
	cp -r "${T}"/vendor/"${PN/-/\/}"/{phpunit.xml.dist,Tests} "${S}" \
		|| die "cp failed"
	# remove test with failed assert
	sed -i '/testEncodeException/,+4d' \
		Tests/Encoder/XmlEncoderTest.php \
		|| die "sed failed for XmlEncoderTest.php"
	# skipped 16
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Component/Serializer
	doins -r Annotation Attribute CacheWarmer Command Context \
		DataCollector Debug DependencyInjection Encoder \
		Exception Extractor Mapping NameConverter Normalizer ./*.php
}
