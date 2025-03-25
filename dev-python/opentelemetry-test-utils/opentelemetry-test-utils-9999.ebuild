# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 git-r3

DESCRIPTION="Test utilities for OpenTelemetry unit tests"
HOMEPAGE="https://github.com/open-telemetry/opentelemetry-python"
EGIT_REPO_URI="https://github.com/open-telemetry/opentelemetry-python.git"
S="${WORKDIR}/${P}/tests/${PN}"

LICENSE="Apache-2.0"
SLOT=0

RDEPEND="dev-python/asgiref[${PYTHON_USEDEP}]
	dev-python/opentelemetry-api[${PYTHON_USEDEP}]
	dev-python/opentelemetry-sdk[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
