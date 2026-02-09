# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="VMware vSphere API Python Bindings"
HOMEPAGE="https://github.com/vmware/pyvmomi"
EGIT_REPO_URI="https://github.com/vmware/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="dev-python/six[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/mock[${PYTHON_USEDEP}]
		dev-python/vcrpy[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# record_mode='new_episodes'
	# my-http-proxy - socket.gaierror: [Errno -2] Name or service not known
	tests/test_connect.py::ConnectionTests::test_http_proxy
)

pkg_postinst() {
	optfeature "single sign-on" dev-python/pyopenssl dev-python/lxml
}
