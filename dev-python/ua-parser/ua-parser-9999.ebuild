# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{4..7}} )
EGIT_REPO_URI="https://github.com/selwin/python-user-agents.git"

PN_CORE="uap-core"
PV_CORE="0.5.0"
P_CORE="${PN_CORE}-${PV_CORE}"

inherit distutils-r1 git-r3

DESCRIPTION="A library for diffs of python data structures"
HOMEPAGE="https://datadiff.sourceforge.net/"
SRC_URI="test? ( https://github.com/ua-parser/${PN_CORE}/archive/v${PV_CORE}.tar.gz -> ${P_CORE}.tar.gz )"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="test"
# some tests fail
RESTRICT="test"

BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="virtual/python-futures[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	test? ( dev-python/pyyaml[${PYTHON_USEDEP}] )"

src_unpack() {
	default

	if use test ; then
		cp -R "${S}"/../"${P_CORE}"/. "${S}"/"${PN_CORE}" \
			|| die "copying of uap-core failed"
	fi
}

python_test() {
	"${PYTHON}" setup.py test || die "tests failed with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all
	find "${D}" -name '*test.*' -delete || die "test removing failed"
}
