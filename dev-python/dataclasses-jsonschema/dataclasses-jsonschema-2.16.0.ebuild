# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )

inherit distutils-r1

DESCRIPTION="JSON schema generation from dataclasses"
HOMEPAGE="https://github.com/s-knibbs/dataclasses-jsonschema"
SRC_URI="https://github.com/s-knibbs/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/jsonschema[${PYTHON_USEDEP}]
	dev-python/mypy_extensions[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? ( dev-python/apispec[${PYTHON_USEDEP}]
		dev-python/apispec-webframeworks[${PYTHON_USEDEP}]
		dev-python/flask[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# AssertionError
	tests/test_core.py::test_embeddable_json_schema
	tests/test_core.py::test_property_serialisation
	tests/test_core.py::test_property_serialisation_all_properties
)

python_prepare_all() {
	export SETUPTOOLS_SCM_PRETEND_VERSION="${PV}"

	# remove pytest-runner
	sed -i "/setup_requires/s/'pytest-runner', //" \
		setup.py || die "sed failed for setup.py"

	distutils-r1_python_prepare_all
}
