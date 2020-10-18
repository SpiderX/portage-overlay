# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )

inherit python-single-r1

DESCRIPTION="A toolkit for testing, tweaking and cracking JSON Web Tokens"
HOMEPAGE="https://github.com/ticarpi/jwt_tool"
SRC_URI="https://github.com/ticarpi/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep 'dev-python/pycryptodome[${PYTHON_USEDEP}]')"
BDEPEND="${RDEPEND}"

src_prepare() {
	default

	sed -i 's/Cryptodome\./Crypto./g' jwt_tool.py \
		|| die "sed failed for jwt_tool.py"
}

src_install() {
	python_doscript jwt_tool.py
}
