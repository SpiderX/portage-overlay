# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/theseer/Autoload.git"

inherit git-r3

DESCRIPTION="PHP Autoload Builder"
HOMEPAGE="https://github.com/theseer/Autoload"

LICENSE="BSD"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*[cli,fileinfo(-),ssl,tokenizer(-)]
	dev-php/theseer-DirectoryScanner
	dev-php/zetacomponents-Base
	dev-php/zetacomponents-ConsoleTools"
BDEPEND="test? ( dev-php/phpunit )"

PATCHES=( "${FILESDIR}/${PN}"-1.26.0-autoload.php.patch )

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	# set version
	sed -i "s/%development%/${PV}/" phpab.php \
		composer/bin/phpab || die "sed failed for phpab"
	# add templates
	install -D -m 644 "${FILESDIR}"/fedora{,2}.php.tpl \
		src/templates/ci || die "install failed"
	# create bootstrap stracture
	mkdir -p vendor/theseer/directoryscanner \
		vendor/zetacomponents/{base,console-tools} \
		|| die "mkdir failed"
	ln -s ../../../../../../../../../../usr/share/php/TheSeer/DirectoryScanner \
		vendor/theseer/directoryscanner/src \
		|| die "ln failed for directoryscanner"
	ln -s ../../../../../../../../../../usr/share/php/ezc/Base \
		vendor/zetacomponents/base/src \
		|| die "ln failed for base"
	ln -s ../../../../../../../../../../usr/share/php/ezc/ConsoleTools \
		vendor/zetacomponents/console-tools/src \
		|| die "ln failed for console-tools"

	./phpab.php -q -o src/autoload.php \
		-t "${FILESDIR}"/autoload.php.tpl src \
		|| die "phpab failed"
}

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/TheSeer/Autoload
	doins -r src/.
	dobin "${S}"/composer/bin/phpab
}
