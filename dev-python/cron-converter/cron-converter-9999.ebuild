# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Cron string parser and scheduler for Python"
HOMEPAGE="https://github.com/Sonic0/cron-converter"
EGIT_REPO_URI="https://github.com/Sonic0/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/python-dateutil[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

python_test() {
	"${EPYTHON}" -m unittest discover -v -s tests/unit \
		|| die "tests failed with ${EPYTHON}"
	"${EPYTHON}" -m unittest discover -v -s tests/integration \
		|| die "tests failed with ${EPYTHON}"
}
