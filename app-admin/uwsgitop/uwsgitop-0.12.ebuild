# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..15} python3_{13..15}t )

inherit distutils-r1 pypi

DESCRIPTION="uWSGI stats viewer"
HOMEPAGE="https://github.com/xrmx/uwsgitop"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
