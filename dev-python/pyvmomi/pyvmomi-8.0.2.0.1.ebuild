# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1 optfeature

DESCRIPTION="VMware vSphere API Python Bindings"
HOMEPAGE="https://github.com/vmware/pyvmomi"
SRC_URI="https://github.com/vmware/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/six[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/vcrpy[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# AttributeError
	tests/test_connect.py::ConnectionTests::test_basic_connection
	tests/test_connect.py::ConnectionTests::test_smart_connection
	tests/test_connect.py::ConnectionTests::test_sspi_connection
	tests/test_container_view.py::ContainerViewTests::test_basic_container_view
	tests/test_deserializer.py::DeserializerTests::test_deserialize_unknown_managed_method
	tests/test_iso8601.py::Iso8601Tests::test_iso8601_set_datetime
	tests/test_iso8601.py::Iso8601Tests::test_vm_config_iso8601
	tests/test_json.py::JSONTests::test_json_datacenter_explode
	tests/test_json.py::JSONTests::test_json_datastore_explode
	tests/test_json.py::JSONTests::test_json_host_explode
	tests/test_json.py::JSONTests::test_json_network_explode
	tests/test_json.py::JSONTests::test_json_vm_explode_default
	tests/test_json.py::JSONTests::test_json_vm_explode_objs_match
	tests/test_json.py::JSONTests::test_json_vm_explode_strip_dynamic
	tests/test_json.py::JSONTests::test_json_vm_explode_type_match
	tests/test_managed_object.py::ManagedObjectTests::test_root_folder_parent
	tests/test_virtual_machine_object.py::VirtualMachineTests::test_vm_nic_data
)

pkg_postinst() {
	optfeature "single sign-on" dev-python/pyopenssl dev-python/lxml
}
