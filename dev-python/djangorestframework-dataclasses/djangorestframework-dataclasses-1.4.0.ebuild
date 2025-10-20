# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

DESCRIPTION="Dataclasses serializer for Django REST framework"
HOMEPAGE="https://github.com/oxan/djangorestframework-dataclasses"
SRC_URI="https://github.com/oxan/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]
	dev-python/djangorestframework[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

export DJANGO_SETTINGS_MODULE=tests.django_settings
