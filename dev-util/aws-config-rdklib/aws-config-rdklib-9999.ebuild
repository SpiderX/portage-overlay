# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..9} )
EGIT_REPO_URI="https://github.com/awslabs/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Rule Development Kit Library for AWS Config"
HOMEPAGE="https://github.com/awslabs/aws-config-rdklib"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-util/aws-config-rdk[${PYTHON_USEDEP}]
	dev-python/boto3[${PYTHON_USEDEP}]
	dev-python/botocore[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
