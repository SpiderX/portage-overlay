# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 edo pypi

DESCRIPTION="Dynamic versioning library and CLI"
HOMEPAGE="https://github.com/mtkennerly/dunamai"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-python/packaging[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-vcs/git )"

distutils_enable_tests pytest

python_prepare_all() {
	if use test ; then
		edo git init > /dev/null
		edo git config --global user.email "${PN}@gentoo.org"
		edo git config --global user.name "${PN}"
	fi

	distutils-r1_python_prepare_all
}
