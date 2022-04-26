# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

MY_PN="${PN}-python"
MY_PV="$(ver_rs 2 ,)"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="A python module that will check for package updates"
HOMEPAGE="https://github.com/akesterson/dpath-python"
SRC_URI="https://github.com/akesterson/${MY_PN}/archive/build,${MY_PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="test? ( dev-python/mock[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_PN}-build-$(ver_rs 2 -)"

distutils_enable_tests nose
