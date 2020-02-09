# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{6..7} )
EGIT_REPO_URI="https://github.com/jazzband/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="A helper for organizing Django project settings"
HOMEPAGE="https://github.com/jazzband/django-configurations"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="test"

DEPEND="dev-python/six[${PYTHON_USEDEP}]"
RDEPEND="dev-python/django[${PYTHON_USEDEP}]"

python_test() {
	"${PYTHON}" -m unittest discover -v || die "tests failed with ${EPYTHON}"
}
