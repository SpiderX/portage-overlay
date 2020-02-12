# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )

inherit python-r1

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
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="!test? ( test )"

RDEPEND="${PYTHON_DEPS}"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

src_unpack() {
	default

	if use test ; then
		cp -R "${S}"/../"${P_TEST}"/. "${S}"/tests/"${PN_TEST}" \
			|| die "copying of toml-test failed"
	fi
}

src_test() {
	py.test -v || die "tests failed with ${EPYTHON}"
}

src_install() {
	einstalldocs
	python_foreach_impl python_domodule tomlkit
}
