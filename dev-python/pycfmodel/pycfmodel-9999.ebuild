# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
EGIT_REPO_URI="https://github.com/Skyscanner/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="A python model for Cloud Formation scripts"
HOMEPAGE="https://github.com/Skyscanner/pycfmodel"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
RESTRICT="test" # needs net

RDEPEND="dev-python/pydantic[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/httpx[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_prepare_all() {
	# Don't install tests
	sed -i '/exclude/s/ts/ts", "tests.*/' setup.py \
		|| die "sed failed for setup.cfg"

	distutils-r1_python_prepare_all
}
