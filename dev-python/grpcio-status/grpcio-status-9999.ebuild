# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..12} )
EGIT_REPO_URI="https://github.com/grpc/grpc.git"

inherit distutils-r1 git-r3

DESCRIPTION="Status proto mapping for gRPC"
HOMEPAGE="https://grpc.io"
S="${WORKDIR}/${P}/src/python/grpcio_status"

LICENSE="Apache-2.0"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-python/googleapis-common-protos[${PYTHON_USEDEP}]
	dev-python/grpcio[${PYTHON_USEDEP}]
	dev-python/protobuf-python[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
