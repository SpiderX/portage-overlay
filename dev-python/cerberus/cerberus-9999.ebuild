# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )
EGIT_REPO_URI="https://github.com/pyeve/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Lightweight and extensible data validation library for Python"
HOMEPAGE="https://github.com/pyeve/cerberus"
SRC_URI=""

LICENSE="ISC"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="!test? ( test )"

distutils_enable_tests pytest

python_prepare_all() {
	# Remove pytest-runner
	sed -i '/setup_requires/d;/pytest-runner/,+1d' setup.py \
		|| die "sed failed for setup.py"

	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "tests" -exec rm -rv {} + || die "tests removing failed"
}
