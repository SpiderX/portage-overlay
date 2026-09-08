# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Jean85"
PHP_REQ_USE="intl?"

inherit composer git-r3

DESCRIPTION="Independent wrapper to get pretty versions strings"
HOMEPAGE="https://github.com/Jean85/pretty-package-versions"
EGIT_REPO_URI="https://github.com/Jean85/pretty-package-versions.git"

LICENSE="MIT"
SLOT="0"
IUSE="intl"
REQUIRED_USE="test? ( intl )"

RDEPEND="dev-php/composer"

PATCHES=( "${FILESDIR}/${PN}"-2.1.1-tests.patch )

composer_enable_tests phpunit

src_compile() { :; }
