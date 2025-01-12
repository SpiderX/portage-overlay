# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )
EGIT_REPO_URI="https://github.com/vmware/${PN}.git"

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="VMware vSphere API Python Bindings"
HOMEPAGE="https://github.com/vmware/pyvmomi"

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="dev-python/six[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/vcrpy[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	tests/test_connect.py::ConnectionTests::test_http_proxy
	tests/test_connect.py::ConnectionTests::test_http_proxy_with_cert_file
	tests/test_connect.py::ConnectionTests::test_ssl_tunnel
	tests/test_connect.py::ConnectionTests::test_ssl_tunnel_http_failure
	tests/test_json.py::JSONTests::test_json_host_explode
	tests/test_json.py::JSONTests::test_json_vm_explode_default
	tests/test_json.py::JSONTests::test_json_vm_explode_objs_match
	tests/test_json.py::JSONTests::test_json_vm_explode_strip_dynamic
	tests/test_json.py::JSONTests::test_json_vm_explode_type_match
)

pkg_postinst() {
	optfeature "single sign-on" dev-python/pyopenssl dev-python/lxml
}
