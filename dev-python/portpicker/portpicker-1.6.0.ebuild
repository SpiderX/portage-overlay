# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} )

inherit distutils-r1 pypi

DESCRIPTION="Library for finding available network ports"
HOMEPAGE="https://github.com/google/python_portpicker"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="ipv6"

RDEPEND="dev-python/psutil[${PYTHON_USEDEP}]"

PATCHES=( "${FILESDIR}/${PN}"-1.6.0-python3.14.patch )

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

src_prepare() {
	default

	use ipv6 || eapply "${FILESDIR}/${PN}"-1.6.0-no-ipv6.patch
}

python_test() {
	local -x PYTHONPATH="${BUILD_DIR}/install/usr/lib/python-exec/${EPYTHON}${PYTHONPATH:+:${PYTHONPATH}}"
	epytest
}
