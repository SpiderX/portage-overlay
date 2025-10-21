# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="Thumbnails for Django"
HOMEPAGE="https://github.com/jazzband/sorl-thumbnail"
EGIT_REPO_URI="https://github.com/jazzband/${PN}.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # broken

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"
BDEPEND="dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? ( dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/pytest-django[${PYTHON_USEDEP}]
		dev-python/redis[${PYTHON_USEDEP}]
		dev-python/wand[${PYTHON_USEDEP}]
		sys-process/lsof )"

distutils_enable_tests pytest

pkg_postinst() {
	optfeature "integration with pillow" dev-python/pillow
	optfeature "integration with redis"  dev-python/redis
	optfeature "integration with wand" dev-python/wand
}
