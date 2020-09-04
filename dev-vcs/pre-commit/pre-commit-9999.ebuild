# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{6,7} )
EGIT_REPO_URI="https://github.com/pre-commit/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="A framework for multi-language pre-commit hooks"
HOMEPAGE="https://github.com/pre-commit/pre-commit"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="dev-python/cfgv[${PYTHON_USEDEP}]
	dev-python/identify[${PYTHON_USEDEP}]
	dev-python/nodeenv[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/toml[${PYTHON_USEDEP}]
	dev-python/importlib_resources[${PYTHON_USEDEP}]
	dev-python/importlib_metadata[${PYTHON_USEDEP}]
	>=dev-python/virtualenv-20.0.31[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-vcs/git
		$(python_gen_impl_dep sqlite) )"

distutils_enable_tests pytest

python_prepare_all() {
	# Remove test, needs network
	rm tests/make_archives_test.py || die "remove make_archives_test.py failed"
	# Remove test, needs various tools
	rm tests/repository_test.py || die "remove repository_test.py failed"
	# Remove tests, needs virtualenv
	sed -i  -e '1 i\import pytest' \
		-e '/test_installed_from_venv/i\@pytest.mark.skip("disable")' \
		-e '/test_environment_not_sourced/i\@pytest.mark.skip("disable")' \
		tests/commands/install_uninstall_test.py \
		|| die "sed failed for install_uninstall_test.py"
	sed -i  -e '/test_healthy_default_creator/i\@pytest.mark.skip("disable")' \
		-e '/test_healthy_venv_creator/i\@pytest.mark.skip("disable")' \
		-e '/test_unhealthy_old_virtualenv/i\@pytest.mark.skip("disable")' \
		tests/languages/python_test.py

	if use test ; then
		git config --global user.email "${PN}@gentoo.org" || die "git config failed"
		git config --global user.name "${PN}" || die "git config failed"
	fi

	distutils-r1_python_prepare_all
}
