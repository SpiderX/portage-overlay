# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8} )

inherit distutils-r1 optfeature

MY_PN="pytest-${PN}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Testinfra test your infrastructures"
HOMEPAGE="https://github.com/pytest-dev/pytest-testinfra"
SRC_URI="https://github.com/pytest-dev/${MY_PN}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/pytest[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools_scm[${PYTHON_USEDEP}]
	test? ( app-admin/ansible[${PYTHON_USEDEP}]
		app-admin/salt[${PYTHON_USEDEP}]
		dev-python/paramiko[${PYTHON_USEDEP}]
		dev-python/pywinrm[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

DOCS=( {CHANGELOG,README}.rst )

distutils_enable_tests pytest

python_prepare_all() {
	# setuptools is unable to detect version
	sed -i  -e "/setup(/a\\        version='${PV}'," \
		-e '/use_scm_version/d' \
		setup.py || die "sed failed for setup.py"
	sed -i "/use_scm_version/s/True/False/" \
		setup.cfg || die "sed failed for setup.cfg"

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
