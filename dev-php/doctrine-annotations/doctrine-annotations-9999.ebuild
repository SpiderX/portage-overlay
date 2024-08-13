# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/doctrine/annotations.git"

inherit git-r3

DESCRIPTION="Doctrine Annotations"
HOMEPAGE="https://github.com/doctrine/annotations"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*[tokenizer]
	dev-php/doctrine-lexer
	dev-php/fedora-autoloader
	dev-php/psr-cache"
BDEPEND="test? ( dev-php/doctrine-common
		dev-php/phpunit
		dev-php/symfony-cache )"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		lib/Doctrine/Common/Annotations/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
	# remove test uses deprecated method withConsecutive
	rm tests/Doctrine/Tests/Common/Annotations/PsrCachedReaderTest.php \
		|| die "rm failed for PsrCachedReaderTest.php"
	# exception annotation deprecated, remove override
	sed -i  -e '/testAnnotationEnumInvalidTypeDeclarationException/,+17d' \
		-e '/testAnnotationEnumInvalidLiteralDeclarationException/,+20d' \
		-e '/testAnnotationWithInvalidTargetDeclarationError/,+27d' \
		-e '/testAnnotationWithTargetEmptyError/,+25d' \
		-e '/function expectExceptionMessageMatches/,+7d' \
		tests/Doctrine/Tests/Common/Annotations/DocParserTest.php
	# fix abstract class with Test suffix
	mv tests/Doctrine/Tests/Common/Annotations/AbstractReaderTest{,X}.php \
		|| die "mv failed for AbstractReaderTest.php"
	sed -i '/abstract class/s|AbstractReaderTest|AbstractReaderTestX|' \
		tests/Doctrine/Tests/Common/Annotations/AbstractReaderTestX.php \
		|| die "sed failed for AbstractReaderTestX.php"
	sed -i '/extends/s|$|X|' tests/Doctrine/Tests/Common/Annotations/AnnotationReaderTest.php \
		|| die "sed failed for AnnotationReaderTest.php"
}

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php
	doins -r lib/.
}
