# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 git-r3

DESCRIPTION="Enhanced completion for bash, fish, zsh in Click"
HOMEPAGE="https://github.com/click-contrib/click-completion"
EGIT_REPO_URI="https://github.com/click-contrib/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/click[${PYTHON_USEDEP}]
	dev-python/jinja2[${PYTHON_USEDEP}]
	dev-python/shellingham[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
