# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{8,10} )

inherit distutils-r1

DESCRIPTION="Command-line tool for looking up colors and palettes"
HOMEPAGE="https://github.com/joowani/colorpedia"
SRC_URI="https://github.com/joowani/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/fire[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

python_prepare_all() {
	# setuptools is unable to detect version
	rm pyproject.toml || die "rm failed"
	sed -i  -e "/setup(/a\\    version=\"${PV}\"," \
		-e "/use_scm_version/d" \
		-e "/setuptools_scm/d" \
		setup.py || die "sed failed for setup.py"

	distutils-r1_python_prepare_all
}
