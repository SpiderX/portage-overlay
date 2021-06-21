# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/awslabs/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="AWS Config Rules Development Kit"
HOMEPAGE="https://github.com/awslabs/aws-config-rdk"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/boto3[${PYTHON_USEDEP}]"
