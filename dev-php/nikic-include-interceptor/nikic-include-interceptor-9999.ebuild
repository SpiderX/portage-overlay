# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="nikic/IncludeInterceptor"

inherit composer git-r3

DESCRIPTION="A library to intercept PHP includes"
HOMEPAGE="https://github.com/nikic/include-interceptor"
EGIT_REPO_URI="https://github.com/nikic/include-interceptor.git"

LICENSE="MIT"
SLOT="0"

DOCS=( {CHANGELOG,README}.md )

composer_enable_tests phpunit
