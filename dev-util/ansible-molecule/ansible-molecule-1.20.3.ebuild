# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_5} )

MY_PN="${PN/ansible-/}"
MY_P="${MY_PN}-${PV}"

inherit bash-completion-r1 distutils-r1

DESCRIPTION="Automated testing for Ansible roles"
HOMEPAGE="https://github.com/metacloud/ansible-molecule https://pypi.python.org/pypi/ansible-molecule"
SRC_URI="https://github.com/metacloud/${MY_PN}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="bash-completion"
DOCS=( AUTHORS.rst CHANGELOG.rst CONTRIBUTING.rst README.rst )
RDEPEND="dev-python/anyconfig[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	>=dev-python/flake8-3.0.4[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/m9dicts[${PYTHON_USEDEP}]
	dev-python/paramiko[${PYTHON_USEDEP}]
	>=dev-python/pexpect-4.2.1[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/sh[${PYTHON_USEDEP}]
	dev-python/tabulate[${PYTHON_USEDEP}]
	dev-python/testinfra[${PYTHON_USEDEP}]
	dev-util/cookiecutter[${PYTHON_USEDEP}]
	dev-util/ansible-lint[${PYTHON_USEDEP}]"
DEPEND="dev-python/pbr[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"

# Remove bash completion
PATCHES=( "${FILESDIR}/${P}-bash.patch" )

python_install_all() {
	distutils-r1_python_install_all
	use bash-completion && newbashcomp asset/bash_completion/molecule.bash-completion.sh molecule
}
