# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/grpc/grpc.git"

inherit distutils-r1 git-r3

DESCRIPTION="Status proto mapping for gRPC"
HOMEPAGE="https://grpc.io"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
RESTRICT="test" # no tests

RDEPEND="dev-python/googleapis-common-protos[${PYTHON_USEDEP}]
	dev-python/grpcio[${PYTHON_USEDEP}]
	dev-python/protobuf-python[${PYTHON_USEDEP}]"

S="${WORKDIR}/${P}/src/python/grpcio_status"

distutils_enable_tests pytest
