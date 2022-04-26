# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/jorisroovers/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Git commit message linter"
HOMEPAGE="https://github.com/jorisroovers/gitlint"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/arrow[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/sh[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

python_prepare_all() {
	# relax requirements
	sed -i  -e '/arrow/s/==/>=/' \
		-e '/Click/s/==/>=/' \
		-e '/sh/s/==/>=/' setup.py || die "sed failed for setup.py"
	# remove symbolic link
	cp --remove-destination README.md gitlint-core || die "cp failed"

	distutils-r1_python_prepare_all
}

python_test() {
	export EDITOR="vim -n"
	epytest gitlint-core
}

python_compile() {
	cd gitlint-core || die "cd failed in compile"
	distutils-r1_python_compile
}

python_install_all() {
	cd gitlint-core || die "cd failed in install"
	distutils-r1_python_install_all
	find "${ED}" -type d -name "tests" -exec rm -rv {} + || die "tests removing failed"
}
