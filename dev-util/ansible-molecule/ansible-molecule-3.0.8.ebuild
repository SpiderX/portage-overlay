# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{6..7} )

MY_PN="${PN/ansible-/}"
MY_P="${MY_PN}-${PV}"

inherit distutils-r1

DESCRIPTION="Automated testing for Ansible roles"
HOMEPAGE="https://github.com/ansible/molecule"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="test" # needs network

RDEPEND="app-admin/ansible[${PYTHON_USEDEP}]
	dev-python/cerberus[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/click-completion[${PYTHON_USEDEP}]
	dev-python/click-help-colors[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/python-gilt[${PYTHON_USEDEP}]
	dev-python/paramiko[${PYTHON_USEDEP}]
	dev-python/pexpect[${PYTHON_USEDEP}]
	dev-python/pluggy[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/selinux[${PYTHON_USEDEP}]
	dev-python/sh[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/tabulate[${PYTHON_USEDEP}]
	dev-python/tree-format[${PYTHON_USEDEP}]
	dev-util/cookiecutter[${PYTHON_USEDEP}]
	dev-util/yamllint[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

distutils_enable_tests pytest
