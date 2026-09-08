# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Amp/WindowsRegistry"

inherit composer git-r3

DESCRIPTION="Windows Registry Reader"
HOMEPAGE="https://github.com/amphp/windows-registry"
EGIT_REPO_URI="https://github.com/amphp/windows-registry.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-php/amphp-byte-stream
	dev-php/amphp-process"
