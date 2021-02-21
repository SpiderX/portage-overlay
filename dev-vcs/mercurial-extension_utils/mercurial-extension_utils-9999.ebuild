# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8} )
EHG_REPO_URI="https://foss.heptapod.net/mercurial/${PN}"

inherit distutils-r1 mercurial

DESCRIPTION="Mercurial Extension Utils"
HOMEPAGE="https://foss.heptapod.net/mercurial/mercurial-extension_utils"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( dev-vcs/mercurial[${PYTHON_USEDEP}] )"

DOCS=( {HISTORY,README}.rst )

python_prepare_all() {
	# Remove tests need access to filesystem
	rm tests/test_doctest.py || die "rm failed"

	distutils-r1_python_prepare_all
}

python_test() {
	"${PYTHON}" -m unittest discover -v tests || die "tests failed with ${EPYTHON}"
}
