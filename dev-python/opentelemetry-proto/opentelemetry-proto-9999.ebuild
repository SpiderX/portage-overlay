# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 git-r3

DESCRIPTION="OpenTelemetry Python Proto"
HOMEPAGE="https://github.com/open-telemetry/opentelemetry-python"
EGIT_REPO_URI="https://github.com/open-telemetry/opentelemetry-python.git"
S="${WORKDIR}/${P}/${PN}"

LICENSE="Apache-2.0"
SLOT=0

RDEPEND=">=dev-python/protobuf-5[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
