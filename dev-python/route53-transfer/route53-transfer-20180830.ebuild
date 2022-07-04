# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

COMMIT="f82d92f1001a1c435323a686b0bd106664e7beb3"

DESCRIPTION="Generic access to configuration files in any formats"
HOMEPAGE="https://github.com/cosmin/route53-transfer"
SRC_URI="https://github.com/cosmin/route53-transfer/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/boto[${PYTHON_USEDEP}]
	dev-python/docopt[${PYTHON_USEDEP}]"

S="${WORKDIR}/${PN}-${COMMIT}"
