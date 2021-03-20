# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=pyproject.toml
PYTHON_COMPAT=( python3_{7..9} )

inherit distutils-r1

DESCRIPTION="Python commitizen client tool"
HOMEPAGE="https://github.com/Woile/commitizen"
SRC_URI="https://github.com/Woile/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/argcomplete[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/decli[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/questionary[${PYTHON_USEDEP}]
	dev-python/termcolor[${PYTHON_USEDEP}]
	dev-python/tomlkit[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-vcs/git
	test? ( dev-python/pytest-mock[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_prepare_all() {
	# Remove failing test requires repository
	rm tests/commands/test_bump_command.py || die "remove test_bump_command.py failed"
	rm tests/commands/test_changelog_command.py || die "remove test_changelog_command.py failed"
	rm tests/test_git.py || die "remove test_git.py failed"

	if use test ; then
		git init || die "git init failed"
		git config user.email "you@example.com" || die "git mail config failed"
		git config user.name "Your Name" || die "git user config failed"
	fi

	distutils-r1_python_prepare_all
}
