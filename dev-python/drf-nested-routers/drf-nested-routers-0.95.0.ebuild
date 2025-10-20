# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

DESCRIPTION="Nested resources for the Django Rest Framework"
HOMEPAGE="https://github.com/alanjds/drf-nested-routers"
SRC_URI="https://github.com/alanjds/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	dev-python/djangorestframework[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=( pytest-django )
distutils_enable_tests pytest
