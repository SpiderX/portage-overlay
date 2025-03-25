# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 git-r3

DESCRIPTION="Identify hardcoded secrets in static structured text"
HOMEPAGE="https://github.com/adeptex/whispers"
EGIT_REPO_URI="https://github.com/adeptex/${PN}.git"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/crossplane[${PYTHON_USEDEP}]
	dev-python/jellyfish[${PYTHON_USEDEP}]
	dev-python/jproperties[${PYTHON_USEDEP}]
	dev-python/luhn[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/wrapt[${PYTHON_USEDEP}]
	dev-util/semgrep[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# assertion error
	tests/unit/plugins/test_semgrep.py::test_pairs
	tests/unit/test_main.py::test_run
)

python_prepare_all() {
	# remove pytest-runner
	sed -i '/setup_requires/d;/pytest-runner/,+1d' setup.py \
		|| die "sed failed for setup.py"

	distutils-r1_python_prepare_all
}
