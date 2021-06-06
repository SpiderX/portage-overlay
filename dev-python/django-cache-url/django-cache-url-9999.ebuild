# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/epicserve/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="URL based cache backend configuration in Django"
HOMEPAGE="https://github.com/epicserve/django-cache-url"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

python_prepare_all() {
	sed -i '/addopts/,+7d' setup.cfg || die "sed failed for setup.cfg"

	distutils-r1_python_prepare_all
}
