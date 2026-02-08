# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Extensions for using Rich with Django"
HOMEPAGE="https://github.com/adamchainz/django-rich"
EGIT_REPO_URI="https://github.com/adamchainz/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	dev-python/rich[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=( pytest-django )
distutils_enable_tests pytest

src_prepare() {
	default

	# remove coverage call
	echo > tests/testapp/__init__.py || die "echo failed"
}
