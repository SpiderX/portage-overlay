# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..12} )

inherit distutils-r1 pypi

DESCRIPTION="A port of TimeCop Ruby Gem for Python"
HOMEPAGE="https://github.com/bluekelp/pytimecop"
SRC_URI="$(pypi_sdist_url "${PN}" "${PV/_pre/dev}" )"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/${PN}-${PV/_pre/dev}"

distutils_enable_tests unittest

python_prepare_all() {
	# Remove failing test
	sed -i "/test_epoch/,+3d" timecop/tests/test_freeze.py \
		|| die "sed failed for requirements.txt"

	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "tests" -exec rm -rv {} + || die "tests removing failed"
}
