# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://git.code.sf.net/p/${PN}/code"

inherit distutils-r1 git-r3

DESCRIPTION="A library for diffs of python data structures"
HOMEPAGE="https://sourceforge.net/projects/datadiff/"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

BDEPEND="test? ( dev-python/six[${PYTHON_USEDEP}] )"

distutils_enable_tests nose

python_prepare_all() {
	# Disable tests
	sed -i  -e '/test_diff_set(set_type=s/i@SkipTest' \
		-e '/test_diff_frozenset(/i@SkipTest' \
		datadiff/tests/test_datadiff.py \
		|| die "sed failed for test_datadiff.py"

	distutils-r1_python_prepare_all
}
