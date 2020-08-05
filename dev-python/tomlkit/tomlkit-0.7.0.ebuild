# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=pyproject.toml
PYTHON_COMPAT=( python3_{6..8} )

inherit distutils-r1

PN_TEST="toml-test"
PV_TEST="f910e151d1b14d94b1e8a4264db0814fb03520d9"
P_TEST="${PN_TEST}-${PV_TEST}"

DESCRIPTION="Style-preserving TOML library for Python"
HOMEPAGE="https://github.com/sdispater/tomlkit"
SRC_URI="https://github.com/sdispater/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
	test? ( https://github.com/BurntSushi/${PN_TEST}/archive/${PV_TEST}.tar.gz -> ${P_TEST}.tar.gz )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

distutils_enable_tests pytest

src_unpack() {
	default

	if use test ; then
		cp -R "${S}"/../"${P_TEST}"/. "${S}"/tests/"${PN_TEST}" \
			|| die "copying of toml-test failed"
	fi
}

python_prepare_all() {
	# Fix backend specification
	sed -i '/build-backend/s/poetry.core.masonry.api/poetry.masonry.api/' \
		pyproject.toml || die "sed failed for pyproject.toml"

	distutils-r1_python_prepare_all
}
