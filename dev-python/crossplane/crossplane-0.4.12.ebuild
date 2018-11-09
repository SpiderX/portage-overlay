# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{4..7}} )

inherit distutils-r1

DESCRIPTION="Fast and reliable NGINX configuration parser"
HOMEPAGE="https://github.com/nginxinc/crossplane"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${PN}-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT=0
KEYWORDS="~amd64 ~x86"
IUSE=""

BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="dev-python/simplejson[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
