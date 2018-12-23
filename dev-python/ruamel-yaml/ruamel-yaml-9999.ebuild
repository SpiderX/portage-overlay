# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{4..6}} )
EHG_REPO_URI="https://bitbucket.org/ruamel/yaml"

inherit distutils-r1 mercurial

DESCRIPTION="YAML parser/emitter that supports roundtrip comment preservation"
HOMEPAGE="https://bitbucket.org/ruamel/yaml"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"

BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/ruamel-std-pathlib[${PYTHON_USEDEP}] )"

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
