# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="Parse and Process AWS IAM Policies, Statements, ARNs"
HOMEPAGE="https://github.com/Netflix-Skunkworks/policyuniverse"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests

distutils_enable_tests pytest

python_prepare_all() {
	# Fix QA
	sed -i '/description/s/-/_/' setup.cfg || die "sed failed"
	distutils-r1_python_prepare_all
}
