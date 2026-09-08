# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="SebastianBergmann/CodeUnitReverseLookup"

inherit composer git-r3

DESCRIPTION="Looks up which function or method a line of code belongs to"
HOMEPAGE="https://github.com/sebastianbergmann/code-unit-reverse-lookup"
EGIT_REPO_URI="https://github.com/sebastianbergmann/code-unit-reverse-lookup.git"

LICENSE="BSD"
SLOT="0"

BDEPEND="dev-php/theseer-Autoload"

DOCS=( {ChangeLog,README}.md )

composer_enable_tests phpunit

src_prepare() {
	composer_src_prepare

	edo phpab -q -o src/autoload.php -t fedora2 src
}
