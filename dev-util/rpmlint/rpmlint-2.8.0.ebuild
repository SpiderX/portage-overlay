# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

DESCRIPTION="Tool for checking common errors in RPM packages"
HOMEPAGE="https://github.com/rpm-software-management/rpmlint"
SRC_URI="https://github.com/rpm-software-management/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="app-arch/cpio
	app-arch/zstd
	$(python_gen_cond_dep 'app-arch/rpm[python,${PYTHON_SINGLE_USEDEP}]
		dev-python/pybeam[${PYTHON_USEDEP}]
		dev-python/pyxdg[${PYTHON_USEDEP}]
		dev-python/tomli-w[${PYTHON_USEDEP}]
		dev-python/zstandard[${PYTHON_USEDEP}]
		dev-python/pyenchant[${PYTHON_USEDEP}]
		dev-python/python-magic[${PYTHON_USEDEP}]
		dev-python/packaging[${PYTHON_USEDEP}]')"
DEPEND="${RDEPEND}"
BDEPEND="test? ( app-shells/dash
		dev-libs/appstream-glib:0=
		dev-util/desktop-file-utils
		|| (
			( app-text/hunspell[l10n_cs,l10n_en] app-text/enchant[hunspell] )
			( app-text/aspell[l10n_cs,l10n_en] app-text/enchant[aspell] )
		) )"

EPYTEST_XDIST=1
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# needs RPM database
	test/test_lint.py::test_run_installed_and_no_files
	test/test_lint.py::test_run_installed
	test/test_lint.py::test_run_strict
	test/test_ldd_parser.py::test_dependencies
	test/test_lint.py::test_installed_package
	test/test_cli.py::test_validate_filters
	test/test_binaries.py::test_forbidden_c_calls
	test/test_binaries.py::test_libtool_wrapper
	test/test_zip.py::test_bad_crc_and_compression
	test/test_zip.py::test_classpath_and_index
	test/test_zip.py::test_zip1
	test/test_zip.py::test_zip2
	test/test_binaries.py::test_shlib_with_no_exec_glibc
	test/test_binaries.py::test_invalid_la_file
	test/test_binaries.py::test_multiple_errors
	test/test_binaries.py::test_invalid_ldconfig_symlink
	test/test_binaries.py::test_shared_library2
	test/test_binaries.py::test_shared_library1
)

python_prepare_all() {
	sed -i '/--cov=rpmlint/d' pytest.ini || die "sed failed"

	distutils-r1_python_prepare_all
}
