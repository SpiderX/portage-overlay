# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Cache/TagInterop"
COMPOSER_INSTALL_SRC="."

inherit composer

DESCRIPTION="Shared interfaces for tags. These are soon-to-be-PSR"
HOMEPAGE="https://github.com/php-cache/tag-interop"
SRC_URI="https://github.com/php-cache/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests

RDEPEND="dev-php/psr-cache"

DOCS=( {Changelog,README}.md )

src_prepare() {
	composer_src_prepare
	edo rm -rf .github
}
