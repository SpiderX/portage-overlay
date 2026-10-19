# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 git-r3

DESCRIPTION="OpenTelemetry Google Cloud Resource Detector"
HOMEPAGE="https://github.com/GoogleCloudPlatform/opentelemetry-operations-python"
EGIT_REPO_URI="https://github.com/GoogleCloudPlatform/opentelemetry-operations-python.git"
S="${WORKDIR}/${P}/${PN}"

LICENSE="Apache-2.0"
SLOT=0

RDEPEND="dev-python/opentelemetry-api[${PYTHON_USEDEP}]
	dev-python/opentelemetry-sdk[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=( syrupy )
distutils_enable_tests pytest
