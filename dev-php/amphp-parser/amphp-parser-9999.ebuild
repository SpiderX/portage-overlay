# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Amp/Parser"

inherit composer git-r3

DESCRIPTION="A generator parser to make streaming parsers simple"
HOMEPAGE="https://github.com/amphp/parser"
EGIT_REPO_URI="https://github.com/amphp/parser.git"

LICENSE="MIT"
SLOT="0"

composer_enable_tests phpunit
