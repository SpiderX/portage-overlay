# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1

DESCRIPTION="Cron string parser and scheduler for Python"
HOMEPAGE="https://github.com/Sonic0/cron-converter"
SRC_URI="https://github.com/Sonic0/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/python-dateutil[${PYTHON_USEDEP}]"

PATCHES=( "${FILESDIR}/${PN}"-1.3.0-test-timezone.patch )

distutils_enable_tests pytest

python_test() {
	"${EPYTHON}" -m unittest discover -v -s tests/unit \
		|| die "tests failed with ${EPYTHON}"
	"${EPYTHON}" -m unittest discover -v -s tests/integration \
		|| die "tests failed with ${EPYTHON}"
}
