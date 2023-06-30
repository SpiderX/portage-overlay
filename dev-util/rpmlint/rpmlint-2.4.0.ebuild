# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1

DESCRIPTION="Tool for checking common errors in RPM packages"
HOMEPAGE="https://github.com/rpm-software-management/rpmlint"
SRC_URI="https://github.com/rpm-software-management/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="app-arch/cpio
	app-arch/zstd
	$(python_gen_cond_dep 'app-arch/rpm[python,${PYTHON_SINGLE_USEDEP}]
		dev-python/pybeam[${PYTHON_USEDEP}]
		dev-python/pyxdg[${PYTHON_USEDEP}]
		dev-python/tomli[${PYTHON_USEDEP}]
		dev-python/tomli-w[${PYTHON_USEDEP}]
		dev-python/zstandard[${PYTHON_USEDEP}]
		dev-python/pyenchant[${PYTHON_USEDEP}]
		dev-python/python-magic[${PYTHON_USEDEP}]')"
DEPEND="${RDEPEND}"
BDEPEND="test? ( app-shells/dash
		dev-libs/appstream-glib:0=
		|| (
			( app-text/hunspell[l10n_cs,l10n_en] app-text/enchant[hunspell] )
			( app-text/aspell[l10n_cs,l10n_en] app-text/enchant[aspell] )
		)
		$(python_gen_cond_dep 'dev-python/pytest-xdist[${PYTHON_USEDEP}]') )"

EPYTEST_DESELECT=(
	# needs RPM database
	test/test_lint.py::test_run_installed_and_no_files
	test/test_lint.py::test_run_installed
	test/test_ldd_parser.py::test_dependencies
	test/test_lint.py::test_installed_package
)

distutils_enable_tests pytest

python_prepare_all() {
	sed -i '/addopts/s/--cov=rpmlint -n auto/-n auto/' \
		setup.cfg || die "sed failed"

	distutils-r1_python_prepare_all
}
