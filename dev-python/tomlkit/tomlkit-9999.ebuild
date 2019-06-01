# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5..7}} )
EGIT_REPO_URI="https://github.com/sdispater/${PN}.git"

inherit git-r3 python-r1

DESCRIPTION="Style-preserving TOML library for Python"
HOMEPAGE="https://github.com/sdispater/decli"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	virtual/python-enum34[${PYTHON_USEDEP}]
	$(python_gen_cond_dep 'dev-python/functools32[${PYTHON_USEDEP}]' '-2')
	$(python_gen_cond_dep 'dev-python/typing[${PYTHON_USEDEP}]' '-2')"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

src_test() {
	py.test -v || die "tests failed with ${EPYTHON}"
}

src_install() {
	einstalldocs
	python_foreach_impl python_domodule tomlkit
}
