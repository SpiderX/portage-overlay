# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=pyproject.toml
PYTHON_COMPAT=( python3_{6,7} )
EGIT_REPO_URI="https://github.com/ansible/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Best practices checker for Ansible"
HOMEPAGE="https://github.com/ansible/ansible-lint"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="app-admin/ansible[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/ruamel-yaml[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools-git[${PYTHON_USEDEP}]
	dev-python/setuptools_scm[${PYTHON_USEDEP}]
	dev-python/setuptools_scm_git_archive[${PYTHON_USEDEP}]
	test? ( dev-python/pytest-xdist[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_prepare_all() {
	# Remove coverage from tests
	sed -i '/-cov/d' pytest.ini || die "sed failed for pytest.ini"

	distutils-r1_python_prepare_all
}
