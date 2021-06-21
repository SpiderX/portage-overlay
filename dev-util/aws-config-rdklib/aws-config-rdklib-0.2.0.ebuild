# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

MY_PN="rdklib"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Rule Development Kit Library for AWS Config"
HOMEPAGE="https://github.com/awslabs/aws-config-rdklib"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-util/aws-config-rdk[${PYTHON_USEDEP}]
	dev-python/boto3[${PYTHON_USEDEP}]
	dev-python/botocore[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"
