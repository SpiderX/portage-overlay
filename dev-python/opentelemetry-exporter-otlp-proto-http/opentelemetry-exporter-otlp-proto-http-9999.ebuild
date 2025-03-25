# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 git-r3

DESCRIPTION="OpenTelemetry Collector Protobuf over HTTP Exporter"
HOMEPAGE="https://github.com/open-telemetry/opentelemetry-python"
EGIT_REPO_URI="https://github.com/open-telemetry/opentelemetry-python.git"
S="${WORKDIR}/${P}/explorer/${PN}"

LICENSE="Apache-2.0"
SLOT=0

RDEPEND="dev-python/deprecated[${PYTHON_USEDEP}]
	dev-python/googleapis-common-protos[${PYTHON_USEDEP}]
	dev-python/opentelemetry-exporter-otlp-proto-common[${PYTHON_USEDEP}]
	dev-python/opentelemetry-api[${PYTHON_USEDEP}]
	dev-python/opentelemetry-proto[${PYTHON_USEDEP}]
	dev-python/opentelemetry-sdk[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/responses[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
