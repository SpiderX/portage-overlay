# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5..7}} )
EHG_REPO_URI="https://bitbucket.org/ruamel/std.pathlib"

inherit distutils-r1 mercurial

DESCRIPTION="Ruamel enhancements to pathlib and pathlib2"
HOMEPAGE="https://bitbucket.org/ruamel/std.pathlib"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="$(python_gen_cond_dep 'dev-python/pathlib2[${PYTHON_USEDEP}]' python3_4)"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

python_test() {
	# tests fail with python2_7 due to import with namespace
	if python_is_python3 ; then
		py.test -v || die "tests failed with ${EPYTHON}"
	fi
}

python_install() {
	distutils-r1_python_install --single-version-externally-managed
	find "${ED}" -name '*.pth' -delete || die "removing of *.pth failed"
}
