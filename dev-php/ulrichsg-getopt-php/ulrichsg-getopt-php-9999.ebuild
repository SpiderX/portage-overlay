# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_AUTOLOAD="src"
COMPOSER_INSTALL_PATH="GetOpt"
COMPOSER_INSTALL_SRC="."
PHP_REQ_USE="unicode"

inherit composer git-r3

DESCRIPTION="A PHP library for command-line argument processing"
HOMEPAGE="https://github.com/getopt-php/getopt-php"
EGIT_REPO_URI="https://github.com/getopt-php/getopt-php.git"

LICENSE="MIT"
SLOT="0"

DOCS=( {CHANGELOG,README}.md )

composer_enable_tests phpunit

src_compile() { :; }
