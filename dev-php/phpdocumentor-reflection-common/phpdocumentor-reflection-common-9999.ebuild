# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_AUTOLOAD="src/Common"
COMPOSER_INSTALL_PATH="phpDocumentor/Reflection"

inherit composer git-r3

DESCRIPTION="phpDocumentor ReflectionCommon component"
HOMEPAGE="https://github.com/phpDocumentor/ReflectionCommon"
EGIT_REPO_URI="https://github.com/phpDocumentor/ReflectionCommon.git"

LICENSE="MIT"
SLOT="0"

composer_enable_tests phpunit

src_compile() { :; }
