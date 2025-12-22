# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Diff and patch tables"
HOMEPAGE="https://github.com/paulfitz/daff"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

python_test() {
	"${EPYTHON}" test/test_{example,sqlite}.py || die "tests failed with ${EPYTHON}"
}
