# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Avro is a serialization and RPC framework"
HOMEPAGE="https://avro.apache.org"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"
PROPERTIES="test_network"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# TypeError
	avro/test/test_io.py
	avro/test/test_schema.py
	# AttributeError
	avro/test/test_protocol.py
)
