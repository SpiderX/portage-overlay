# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=uv-build
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 edo git-r3

DESCRIPTION="Python commitizen client tool"
HOMEPAGE="https://github.com/commitizen-tools/commitizen"
EGIT_REPO_URI="https://github.com/commitizen-tools/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/argcomplete[${PYTHON_USEDEP}]
	dev-python/charset-normalizer[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/decli[${PYTHON_USEDEP}]
	dev-python/jinja2[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/questionary[${PYTHON_USEDEP}]
	dev-python/termcolor[${PYTHON_USEDEP}]
	dev-python/tomlkit[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-vcs/git
	test? ( dev-python/deprecated[${PYTHON_USEDEP}] )"

DOCS="CHANGELOG.md docs/*.md"

EPYTEST_XDIST=1
EPYTEST_PLUGINS=( pytest-{datadir,freezer,gitconfig,mock,regressions} )
distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# no real git
	tests/test_git.py::test_get_commits_with_signature
	tests/test_bump_create_commit_message.py::test_bump_pre_commit_changelog_fails_always
)

src_prepare() {
	if use test ; then
		edo git init > /dev/null
		edo git config user.email "you@example.com"
		edo git config user.name "Your Name"
	fi

	distutils-r1_src_prepare
}
