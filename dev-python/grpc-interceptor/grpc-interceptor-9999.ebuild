# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Simplifies gRPC interceptors"
HOMEPAGE="https://github.com/d5h-foss/grpc-interceptor"
EGIT_REPO_URI="https://github.com/d5h-foss/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/grpcio[${PYTHON_USEDEP}]
	dev-python/protobuf[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest
