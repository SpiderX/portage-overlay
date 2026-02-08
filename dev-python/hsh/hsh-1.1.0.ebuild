# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 edo pypi

DESCRIPTION="Simple cross-platform file hash digests and file integrity checks"
HOMEPAGE="https://github.com/chrissimpkins/hsh"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests

RDEPEND="dev-python/commandlines[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

python_test() {
	edo pushd tests
	epytest -v
	edo popd
}
