# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )
EGIT_REPO_URI="https://github.com/awslabs/${PN}.git"

inherit git-r3 python-single-r1

DESCRIPTION="A toolkit for testing, tweaking and cracking JSON Web Tokens"
HOMEPAGE="https://github.com/ticarpi/jwt_tool"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
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
