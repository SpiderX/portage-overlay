# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="http2jp/hpack-test-case"
COMPOSER_INSTALL_SRC="."

inherit composer git-r3

DESCRIPTION="HPACK Test Case"
HOMEPAGE="https://github.com/http2jp/hpack-test-case"
EGIT_REPO_URI="https://github.com/http2jp/hpack-test-case.git"

LICENSE="MIT"
SLOT="0"
