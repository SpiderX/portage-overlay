# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Simple cross-platform file hash digests and file integrity checks"
HOMEPAGE="https://github.com/chrissimpkins/hsh"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests

RDEPEND="dev-python/commandlines[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

python_test() {
	pushd tests || die "pushd failed"
	epytest -v || die "tests failed with ${EPYTHON}"
	popd || die "popd failed"
}
