# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="ezc/ConsoleTools"
PHP_REQ_USE="iconv(-)"

inherit composer

DESCRIPTION="A set of classes to do different actions with the console"
HOMEPAGE="https://github.com/zetacomponents/ConsoleTools"
SRC_URI="https://github.com/zetacomponents/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/zetacomponents-Base"
BDEPEND="dev-php/theseer-Autoload
	test? ( dev-php/zetacomponents-UnitTest )"

PATCHES=( "${FILESDIR}/${PN}"-1.7.5-tests-bootstrap.patch
	"${FILESDIR}/${PN}"-1.7.5-tests-dialog_test.patch
	"${FILESDIR}/${PN}"-1.7.5-tests-phpunit.xml.patch
	"${FILESDIR}/${PN}"-1.7.5-tests-string_tools_test.patch )

composer_enable_tests phpunit

src_prepare() {
	composer_src_prepare

	edo phpab -q -o src/autoload.php -t "${FILESDIR}"/autoload.php.tpl src

	# PHPUnit 12 requires test filenames to match their class names.
	# rename legacy Zeta Components tests and update PHPUnit discovery.
	local file class
	for file in tests/*_test.php ; do
		class=$(sed -nE 's/^(abstract )?class (ezc[^ ]+Test) extends .*/\2/p' "${file}")
		[[ -n ${class} ]] || die "missing test class in ${file}"
		mv "${file}" tests/"${class}".php || die "mv failed for ${class}.php"
	done

	sed -i '/suffix="/s|_test|Test|' phpunit.xml.dist || die "sed failed for phpunit.xml.dist"
}

src_test() {
	ephpunit
}
