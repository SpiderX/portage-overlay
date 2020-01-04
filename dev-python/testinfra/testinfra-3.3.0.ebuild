# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_6 )

inherit distutils-r1 eutils

DESCRIPTION="Testinfra test your infrastructures"
HOMEPAGE="https://github.com/philpep/testinfra"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/pytest[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/setuptools_scm[${PYTHON_USEDEP}]
	test? ( app-admin/ansible[${PYTHON_USEDEP}]
		app-admin/salt[${PYTHON_USEDEP}]
		dev-python/paramiko[${PYTHON_USEDEP}]
		dev-python/pywinrm[${PYTHON_USEDEP}] )"

python_prepare_all() {
	# Disable test
	sed -i '/test_parse_socketspec/i@pytest.mark.skip(reason="disable")' \
		test/test_modules.py || die "sed failed for tests/test_modules.py"

	distutils-r1_python_prepare_all
}

python_test() {
	py.test -v || die "tests failed with ${EPYTHON}"
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
