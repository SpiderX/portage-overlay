# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 mercurial

DESCRIPTION="Mercurial Extension Utils"
HOMEPAGE="https://foss.heptapod.net/mercurial/mercurial-extension_utils"
EHG_REPO_URI="https://foss.heptapod.net/mercurial/${PN}"

LICENSE="BSD"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( dev-vcs/mercurial[${PYTHON_USEDEP}] )"

DOCS=( {HISTORY,README}.rst )

distutils_enable_tests unittest

python_prepare_all() {
	# Remove tests need access to filesystem
	rm tests/test_doctest.py || die "rm failed"

	distutils-r1_python_prepare_all
}

python_test() {
	"${PYTHON}" -m unittest discover -v tests || die "tests failed with ${EPYTHON}"
}
