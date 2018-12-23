# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_{4..6}} )

MY_PN="${PN//-/.}"
MY_P="${MY_PN}-${PV}"

inherit distutils-r1 vcs-snapshot

DESCRIPTION="YAML parser/emitter that supports roundtrip comment preservation"
HOMEPAGE="https://bitbucket.org/ruamel/yaml"
SRC_URI="https://bitbucket.org/${MY_PN/.//}/get/${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/ruamel-std-pathlib[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

python_test() {
	# This file produced by setup.py breaks finding system-wide installed
	# ruamel.std.pathlib due to shared namespace
	rm "${BUILD_DIR}/lib/ruamel/__init__.py" || die "rm failed"

	# tests fail with python2_7 due to import with namespace
	if python_is_python3 ; then
		py.test -v _test/test_*.py || die "tests failed with ${EPYTHON}"
	fi
}

python_install() {
	distutils-r1_python_install --single-version-externally-managed
	find "${ED}" -name '*.pth' -delete || die "removing of *.pth failed"
}
