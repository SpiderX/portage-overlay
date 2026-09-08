# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Composer/Pcre"

inherit composer

DESCRIPTION="PCRE wrapping library that offers type-safe preg_ replacements"
HOMEPAGE="https://github.com/composer/pcre"
SRC_URI="https://github.com/composer/${COMPOSER_PKG}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

# exclude tests rely on old warning-expectation API
EPHPUNIT_EXCLUDE_FILTER='BadPatternTriggersWarningByDefault'
composer_enable_tests phpunit
