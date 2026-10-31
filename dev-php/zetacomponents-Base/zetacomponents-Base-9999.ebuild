# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="ezc/Base"

inherit composer git-r3

DESCRIPTION="Base package for any Zeta component"
HOMEPAGE="https://github.com/zetacomponents/Base"
EGIT_REPO_URI="https://github.com/zetacomponents/Base.git"

LICENSE="Apache-2.0"
SLOT="0"

BDEPEND="dev-php/theseer-Autoload
	test? ( dev-php/zetacomponents-UnitTest )"

PATCHES=( "${FILESDIR}/${PN}"-1.9.5-unit-test-autoload.patch )

composer_enable_tests phpunit

src_prepare() {
	composer_src_prepare

	edo phpab -q -o src/autoload.php -t "${FILESDIR}"/autoload.php.tpl src

	# create bootstrap stracture
	edo mkdir -p vendor/zetacomponents/unit-test
	edo ln -s ../../../../../../../../../../usr/share/php/ezc/UnitTest \
		vendor/zetacomponents/unit-test/src
	edo ln -s ../../../../../../../../../../usr/share/zetacomponents/UnitTest/design \
		vendor/zetacomponents/unit-test/design

	# PHPUnit 12 requires test filenames to match their class names.
	# Rename legacy Zeta Components tests and update PHPUnit discovery.
	local file class
	for file in tests/*_test.php ; do
		class=$(sed -nE 's/^class (ezc[^ ]+Test) extends .*/\1/p' "${file}")
		[[ -n ${class} ]] || die "missing test class in ${file}"
		mv "${file}" "tests/${class}.php" || die
	done

	sed -i '/suffix="/s|_test|Test|' phpunit.xml.dist || die
}

src_test() {
	ephpunit
}
