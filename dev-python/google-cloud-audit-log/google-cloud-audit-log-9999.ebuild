# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 git-r3

DESCRIPTION="Python Client for Audit Log"
HOMEPAGE="https://github.com/googleapis/google-cloud-python"
EGIT_REPO_URI="https://github.com/googleapis/google-cloud-python.git"
S="${WORKDIR}/${P}/packages/${PN}"

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="dev-python/googleapis-common-protos[${PYTHON_USEDEP}]
	dev-python/protobuf[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
