# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )

inherit git-r3 python-single-r1

DESCRIPTION="A toolkit for testing, tweaking and cracking JSON Web Tokens"
HOMEPAGE="https://github.com/ticarpi/jwt_tool"
EGIT_REPO_URI="https://github.com/ticarpi/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep 'dev-python/cprint[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/pycryptodome[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/ratelimit[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/requests[${PYTHON_USEDEP}]')
	$(python_gen_cond_dep 'dev-python/termcolor[${PYTHON_USEDEP}]')"

src_prepare() {
	default

	sed -i 's/Cryptodome\./Crypto./g' jwt_tool.py \
		|| die "sed failed for jwt_tool.py"
}

src_install() {
	python_doscript jwt_tool.py
}
