# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Python library to read characters and key strokes"
HOMEPAGE="https://github.com/magmax/python-readchar"
EGIT_REPO_URI="https://github.com/magmax/python-readchar.git"

LICENSE="MIT"
SLOT="0"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

python_prepare_all() {
	# remove coverage
	sed -i '/addopts/s| --cov=readchar||' .pytest.ini || die "sed failed for .pytest.ini"

	distutils-r1_python_prepare_all
}
