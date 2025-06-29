# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 edo pypi

DESCRIPTION="Plugin for Poetry to enable dynamic versioning based on VCS tags"
HOMEPAGE="https://github.com/mtkennerly/poetry-dynamic-versioning"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/dunamai[${PYTHON_USEDEP}]
	dev-python/tomlkit[${PYTHON_USEDEP}]
	dev-python/jinja2[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-vcs/git )"

PATCHES=( "${FILESDIR}/${PN}"-1.8.2-tests.patch )

distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# ignore intergration tests
	tests/test_integration.py
)

python_prepare_all() {
	if use test ; then
		edo git init > /dev/null
		edo git config --global user.email "${PN}@gentoo.org"
		edo git config --global user.name "${PN}"
	fi

	distutils-r1_python_prepare_all
}
