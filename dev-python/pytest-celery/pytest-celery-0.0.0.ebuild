# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS=no
PYTHON_COMPAT=( python3_{8,10} )

inherit distutils-r1

DESCRIPTION="A shim pytest plugin to enable celery.contrib.pytest"
HOMEPAGE="https://github.com/celery/pytest-celery"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/celery[${PYTHON_USEDEP}]"
