# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="Command line tool to select files out of bash output"
HOMEPAGE="https://github.com/facebook/pathpicker"
SRC_URI="https://github.com/facebook/pathpicker/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/PathPicker-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# IndexError: list index out of range
	src/tests/test_screen.py::TestScreenLogic::test_screen_inputs
)

src_install() {
	distutils-r1_src_install

	insinto /usr/share/fpp/src
	doins src/{choose,print_help,process_input,version}.py
	insinto /usr/share/fpp
	doins fpp
	fperms +x /usr/share/fpp/fpp
	dosym ../share/fpp/fpp usr/bin/fpp
	doman debian/usr/share/man/man1/fpp.1
}