# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 git-r3

DESCRIPTION="Instrumentation Tools for OpenTelemetry Python"
HOMEPAGE="https://github.com/open-telemetry/opentelemetry-contrib"
EGIT_REPO_URI="https://github.com/open-telemetry/opentelemetry-python-contrib.git"
S="${WORKDIR}/${P}/${PN}"

LICENSE="Apache-2.0"
SLOT=0

RDEPEND="dev-python/opentelemetry-api[${PYTHON_USEDEP}]
	dev-python/opentelemetry-semantic-conventions[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/wrapt[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
