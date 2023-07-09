# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10,11} )

inherit distutils-r1

DESCRIPTION="Python commitizen client tool"
HOMEPAGE="https://github.com/commitizen-tools/commitizen"
SRC_URI="https://github.com/commitizen-tools/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/argcomplete[${PYTHON_USEDEP}]
	dev-python/charset-normalizer[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/decli[${PYTHON_USEDEP}]
	dev-python/importlib-metadata[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/questionary[${PYTHON_USEDEP}]
	dev-python/termcolor[${PYTHON_USEDEP}]
	dev-python/tomlkit[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-vcs/git
	test? ( dev-python/pytest-freezegun[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/pytest-regressions[${PYTHON_USEDEP}] )"

DOCS="CHANGELOG.md docs/*.md"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	tests/test_bump_create_commit_message.py
	tests/test_bump_create_commit_message.py::test_bump_pre_commit_changelog
	tests/test_git.py::test_get_commits_with_signature
)

python_prepare_all() {
	if use test ; then
		git init || die "git init failed"
		git config user.email "you@example.com" || die "git mail config failed"
		git config user.name "Your Name" || die "git user config failed"
	fi

	distutils-r1_python_prepare_all
}
