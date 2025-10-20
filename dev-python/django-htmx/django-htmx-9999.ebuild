# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Extensions for using Django with htmx"
HOMEPAGE="https://github.com/adamchainz/django-htmx"
EGIT_REPO_URI="https://github.com/adamchainz/${PN}.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/asgiref[${PYTHON_USEDEP}]
	dev-python/django[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=( pytest-django )
distutils_enable_tests pytest
