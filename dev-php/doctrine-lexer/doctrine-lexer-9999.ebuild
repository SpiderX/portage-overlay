# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Doctrine/Common/Lexer"

inherit composer git-r3

DESCRIPTION="Doctrine Lexer"
HOMEPAGE="https://github.com/doctrine/lexer"
EGIT_REPO_URI="https://github.com/doctrine/lexer.git"

LICENSE="MIT"
SLOT="0"

composer_enable_tests phpunit
