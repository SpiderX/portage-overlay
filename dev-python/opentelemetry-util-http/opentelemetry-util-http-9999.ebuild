# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Web util for OpenTelemetry"
HOMEPAGE="https://github.com/open-telemetry/opentelemetry-python-contrib"
EGIT_REPO_URI="https://github.com/open-telemetry/opentelemetry-python-contrib.git"
S="${WORKDIR}/${P}/util/${PN}"

LICENSE="Apache-2.0"
SLOT=0

BDEPEND="test? ( dev-python/opentelemetry-instrumentation[${PYTHON_USEDEP}]
		dev-python/opentelemetry-test-utils[${PYTHON_USEDEP}] )"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

EPYTEST_DESELECT=( tests/test_http_base.py::TestHttpBase::test_uninstrument )
