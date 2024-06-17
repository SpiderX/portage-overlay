# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="Assertion library for unit testing"
HOMEPAGE="https://github.com/assertpy/assertpy"
SRC_URI="https://github.com/assertpy/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

distutils_enable_tests pytest

python_prepare_all() {
	# fix QA
	sed -i '/description/s/-/_/' setup.cfg || die "sed failed"
	distutils-r1_python_prepare_all
}
