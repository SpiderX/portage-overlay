# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 git-r3

DESCRIPTION="Python runtime library for ANTLR 3-generated parsers"
HOMEPAGE="https://github.com/antlr/antlr3"
EGIT_REPO_URI="https://github.com/antlr/antlr3.git"
S="${WORKDIR}/${P}/runtime/Python3"

LICENSE="BSD"
SLOT="0"

distutils_enable_tests unittest

src_prepare() {
	sed -i  -e '/^import ez_setup$/d' \
		-e '/^ez_setup.use_setuptools()$/d' \
		-e '/^from distutils.core import setup$/d' \
		-e "/version=/s|3.4|${PV}|" \
		setup.py || die "sed failed for setup.py"
	sed -i "/__version__/s|3.4|${PV}|" antlr3/__init__.py \
		|| die "sed failed for init"

	distutils-r1_src_prepare
}

python_test() {
	"${EPYTHON}" -m unittest discover -s unittests -v
}
