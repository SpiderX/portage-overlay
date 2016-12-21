# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 ) # python3_{3,4,5} - readd after drf supports it in the ebuild

inherit distutils-r1

DESCRIPTION="Swagger Documentation Generator for Django REST Framework"
HOMEPAGE="https://github.com/marcgibbons/django-rest-swagger"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="dev-python/django[${PYTHON_USEDEP}]
		dev-python/django-rest-framework[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/markdown[${PYTHON_USEDEP}]
		dev-python/argh[${PYTHON_USEDEP}]
		dev-python/django-filter[${PYTHON_USEDEP}]
		dev-python/jsonschema[${PYTHON_USEDEP}]
		dev-python/ordereddict[${PYTHON_USEDEP}]"
