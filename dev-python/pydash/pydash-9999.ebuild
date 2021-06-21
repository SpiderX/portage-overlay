# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/dgilland/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="The kitchen sink of Python functional utility libraries"
HOMEPAGE="https://github.com/dgilland/pydash"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

BDEPEND="test? ( dev-python/mock[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_prepare_all() {
	# Remove pytest plugin usage
	sed -i '/addopts/,+8d' setup.cfg \
		|| die "sed failed for setup.cfg"

	distutils-r1_python_prepare_all
}
