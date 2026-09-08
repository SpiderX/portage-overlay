# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="http2jp/hpack-test-case"
COMPOSER_INSTALL_SRC="."

inherit composer

COMMIT="8a1406e7d14bfcb6c046021f13cc15cfb162726d"

DESCRIPTION="HPACK Test Case"
HOMEPAGE="https://github.com/http2jp/hpack-test-case"
SRC_URI="https://github.com/http2jp/${COMPOSER_PKG}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${COMPOSER_PKG}-${COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( README.md )
