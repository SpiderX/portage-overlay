# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/jorisroovers/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Git commit message linter"
HOMEPAGE="https://github.com/jorisroovers/gitlint"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND=">=dev-python/arrow-0.14.2[${PYTHON_USEDEP}]
	>=dev-python/click-7.0[${PYTHON_USEDEP}]
	dev-python/sh[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

distutils_enable_tests unittest

python_prepare_all() {
	# Relax requirements
	sed -i  -e '/arrow/s/==/>=/' \
		-e '/Click/s/==/>=/' \
		-e '/sh/s/==/>=/' setup.py || die "sed failed for setup.py"

	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -type d -name "tests" -exec rm -rv {} + || die "tests removing failed"
	find "${ED}" -type d -name "qa" -exec rm -rv {} + || die "integration tests removing failed"
}
