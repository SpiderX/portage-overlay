# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

DESCRIPTION="Cute DI framework with scopes and agreeable API"
HOMEPAGE="https://github.com/reagento/dishka"
SRC_URI="https://github.com/reagento/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

EPYTEST_PLUGINS=( pytest-{asyncio,repeat} )
distutils_enable_tests pytest

EPYTEST_IGNORE=( tests/integrations )

python_prepare_all() {
	# disable pytest options
	sed -i '/addopts/d' .pytest.ini || die "sed failed for .pytest.ini"

	distutils-r1_python_prepare_all
}

python_test() {
	epytest -v tests
}
