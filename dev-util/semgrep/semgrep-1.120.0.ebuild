# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 edo

SI_PV="1.119.0"

DESCRIPTION="Lightweight static analysis for many languages"
HOMEPAGE="https://github.com/semgrep/semgrep"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz
	https://github.com/${PN}/${PN}-interfaces/archive/v${SI_PV}.tar.gz -> ${PN}-interfaces-${SI_PV}.gh.tar.gz"
S="${WORKDIR}/${P}/cli"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test" # tests in live ebuild

RDEPEND="dev-python/attrs[${PYTHON_USEDEP}]
	dev-python/boltons[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/click-option-group[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/defusedxml[${PYTHON_USEDEP}]
	dev-python/exceptiongroup[${PYTHON_USEDEP}]
	dev-python/glom[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]
	dev-python/opentelemetry-api[${PYTHON_USEDEP}]
	dev-python/opentelemetry-instrumentation-requests[${PYTHON_USEDEP}]
	dev-python/opentelemetry-exporter-otlp-proto-http[${PYTHON_USEDEP}]
	dev-python/opentelemetry-sdk[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/peewee[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/rich[${PYTHON_USEDEP}]
	dev-python/ruamel-yaml[${PYTHON_USEDEP}]
	dev-python/tomli[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
	dev-python/wcmatch[${PYTHON_USEDEP}]
	dev-util/semgrep-core-bin"
BDEPEND="test? ( dev-python/appdirs[${PYTHON_USEDEP}]
		dev-python/freezegun[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/requests-mock[${PYTHON_USEDEP}]
		dev-python/snapshottest[${PYTHON_USEDEP}] )"

EPYTEST_XDIST=1
distutils_enable_tests pytest

python_prepare_all() {
	# provide access to semgrep-interfaces
	edo rmdir src/semgrep/semgrep_interfaces
	edo ln -s ../../../../semgrep-interfaces-"${SI_PV}" \
		src/semgrep/semgrep_interfaces

	distutils-r1_python_prepare_all
}
