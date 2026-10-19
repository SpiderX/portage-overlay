# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 optfeature

DESCRIPTION="Kubernetes Python Client"
HOMEPAGE="https://github.com/kubernetes-client/python"
SRC_URI="https://github.com/kubernetes-client/python/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/python-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/certifi[${PYTHON_USEDEP}]
	dev-python/durationpy[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pydantic[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/requests-oauthlib[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
	dev-python/websocket-client[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

pkg_postinst() {
	optfeature "integration with google auth" dev-python/google-auth
}
