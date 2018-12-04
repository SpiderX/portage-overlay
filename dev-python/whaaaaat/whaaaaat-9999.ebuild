# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{4..6}} )
EGIT_REPO_URI="https://github.com/finklabs/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="A collection of common interactive command line user interfaces"
HOMEPAGE="https://github.com/finklabs/whaaaaat"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"
# tests fail
RESTRICT="test"

RDEPEND="dev-python/pygments[${PYTHON_USEDEP}]
	<dev-python/prompt_toolkit-2[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? (	dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/ptyprocess[${PYTHON_USEDEP}]
		dev-python/regex[${PYTHON_USEDEP}] )"

python_prepare_all() {
	# Remove unneeded requirement
	sed -i '/regex/d' requirements.txt \
		|| die "sed failed for requirements.txt"

	distutils-r1_python_prepare_all
}
