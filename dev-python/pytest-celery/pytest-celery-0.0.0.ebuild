# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=no
PYTHON_COMPAT=( python3_{7,8} )

inherit distutils-r1

DESCRIPTION="A shim pytest plugin to enable celery.contrib.pytest"
HOMEPAGE="https://github.com/celery/pytest-celery"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/celery[${PYTHON_USEDEP}]"
