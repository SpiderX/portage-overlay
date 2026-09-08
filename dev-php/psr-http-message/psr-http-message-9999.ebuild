# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Psr/Http/Message"

inherit composer git-r3

DESCRIPTION="Common interfaces for HTTP messages"
HOMEPAGE="https://github.com/php-fig/http-message"
EGIT_REPO_URI="https://github.com/php-fig/http-message.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

DOCS=( {CHANGELOG,README}.md )
