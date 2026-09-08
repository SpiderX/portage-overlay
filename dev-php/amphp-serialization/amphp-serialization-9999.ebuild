# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Amp/Serialization"

inherit composer git-r3

DESCRIPTION="Serialization tools for IPC and data storage in PHP"
HOMEPAGE="https://github.com/amphp/serialization"
EGIT_REPO_URI="https://github.com/amphp/serialization.git"

LICENSE="MIT"
SLOT="0"

PATCHES=( "${FILESDIR}/${PN}"-1.0.0-tests-JsonSerializerTest.patch
	"${FILESDIR}/${PN}"-1.0.0-tests-NativeSerializerTest.patch )

composer_enable_tests phpunit
