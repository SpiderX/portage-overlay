# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Psr/Http/Client"

inherit composer git-r3

DESCRIPTION="Common interfaces for HTTP Client"
HOMEPAGE="https://github.com/php-fig/http-client"
EGIT_REPO_URI="https://github.com/php-fig/http-client.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-php/psr-http-message"

DOCS=( {CHANGELOG,README}.md )
