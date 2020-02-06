# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit distutils-r1

DESCRIPTION="Best practices checker for Ansible"
HOMEPAGE="https://github.com/ansible/ansible-lint"
SRC_URI="https://github.com/ansible/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="app-admin/ansible[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	$(python_gen_cond_dep 'dev-python/ruamel-yaml[${PYTHON_USEDEP}]' python3_6)
	$(python_gen_cond_dep '>=dev-python/ruamel-yaml-0.15.37[${PYTHON_USEDEP}]' python3_7)"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools-git[${PYTHON_USEDEP}]
	dev-python/setuptools_scm[${PYTHON_USEDEP}]
	dev-python/setuptools_scm_git_archive[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

python_prepare_all() {
	# distutils-r1.eclass: Add pyproject.toml support
	cp "${FILESDIR}"/setup.py "${S}" || die "cp failed"
	chmod +x setup.py || die "chmod failed"

	distutils-r1_python_prepare_all
}

python_test() {
	nosetests -v || die "tests failed with ${EPYTHON}"
}
