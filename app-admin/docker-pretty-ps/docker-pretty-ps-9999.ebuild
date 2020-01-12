# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{4..7} )
EGIT_REPO_URI="https://github.com/politeauthority/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="docker ps in colored and long output"
HOMEPAGE="https://github.com/politeauthority/docker-pretty-ps"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] ) "

python_prepare_all() {
	# Don't install tests
	sed -i '/find_packages/s/)/exclude=["tests*"])/' setup.py \
		|| die "sed failed for setup.py"

	distutils-r1_python_prepare_all
}

python_test() {
	py.test -v || die "tests failed with ${EPYTHON}"
}
