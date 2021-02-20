# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8} )
EGIT_REPO_URI="https://github.com/pytest-dev/pytest-testinfra.git"

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="Testinfra test your infrastructures"
HOMEPAGE="https://github.com/pytest-dev/pytest-testinfra"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="dev-python/pytest[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools_scm[${PYTHON_USEDEP}]
	test? ( app-admin/ansible[${PYTHON_USEDEP}]
		app-admin/salt[${PYTHON_USEDEP}]
		dev-python/paramiko[${PYTHON_USEDEP}]
		dev-python/pywinrm[${PYTHON_USEDEP}] )"

DOCS=( {CHANGELOG,README}.rst )

distutils_enable_tests pytest

python_prepare_all() {
	# Disable test
	sed -i '/test_parse_socketspec/i@pytest.mark.skip(reason="disable")' \
		test/test_modules.py || die "sed failed for tests/test_modules.py"

	distutils-r1_python_prepare_all
}

pkg_postinst() {
	optfeature "integration with ansible" app-admin/ansible
	optfeature "integration with docker" app-emulation/docker
	optfeature "integration with kubectl" sys-cluster/kubectl
	optfeature "integration with lxc" app-emulation/lxc
	optfeature "integration with paramiko" dev-python/paramiko
	optfeature "integration with salt" app-admin/salt
	optfeature "integration with ssh" virtual/ssh
	optfeature "integration with winrm" dev-python/pywinrm
}
