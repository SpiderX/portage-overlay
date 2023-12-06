# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10,11} )

inherit distutils-r1

COMMIT="f3b25d9ea875ef11a8afd54b9516f079eb29387f"

DESCRIPTION="Generic access to configuration files in any formats"
HOMEPAGE="https://github.com/cosmin/route53-transfer"
SRC_URI="https://github.com/cosmin/route53-transfer/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/boto[${PYTHON_USEDEP}]
	dev-python/docopt[${PYTHON_USEDEP}]"

S="${WORKDIR}/${PN}-${COMMIT}"

distutils_enable_tests pytest
