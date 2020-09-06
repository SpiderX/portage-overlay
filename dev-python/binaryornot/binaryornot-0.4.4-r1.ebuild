# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )

inherit distutils-r1

DESCRIPTION="Python package to guess whether a file is binary or text"
HOMEPAGE="https://github.com/audreyfeldroy/binaryornot"
SRC_URI="https://github.com/audreyfeldroy/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/chardet[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/hypothesis[${PYTHON_USEDEP}] )"

PATCHES=( "${FILESDIR}"/"${P}"-tests.patch )

distutils_enable_tests unittest

python_prepare_all() {
	# Fix version
	sed -i '/version =/s/3/4/' setup.py \
		|| die "sed failed for setup.py"

	distutils-r1_python_prepare_all
}
