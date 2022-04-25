# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/commitizen-tools/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Python commitizen client tool"
HOMEPAGE="https://github.com/commitizen-tools/commitizen"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/argcomplete[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/decli[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/questionary[${PYTHON_USEDEP}]
	dev-python/termcolor[${PYTHON_USEDEP}]
	dev-python/tomlkit[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-vcs/git
	test? ( dev-python/pytest-freezegun[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/pytest-regressions[${PYTHON_USEDEP}] )"

DOCS="CHANGELOG.md docs/*.md"

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
