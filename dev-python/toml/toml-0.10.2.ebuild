# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 edo pypi

COMMIT="280497fa5f12e43d7233aed0d74e07ca61ef176b"

DESCRIPTION="Python Library for TOML"
HOMEPAGE="https://github.com/uiri/toml"
SRC_URI+=" test? ( https://github.com/BurntSushi/toml-test/archive/${COMMIT}.tar.gz
		-> toml-test-${COMMIT}.tar.gz )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

BDEPEND="test? ( dev-python/numpy[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_prepare_all() {
	if use test; then
		edo mv "${WORKDIR}"/toml-test-"${COMMIT}" "${S}"/toml-test
	fi

	distutils-r1_python_prepare_all
}
