# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 git-r3

DESCRIPTION="Rule Development Kit Library for AWS Config"
HOMEPAGE="https://github.com/awslabs/aws-config-rdklib"
EGIT_REPO_URI="https://github.com/awslabs/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="dev-util/aws-config-rdk[${PYTHON_USEDEP}]
	dev-python/boto3[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]"
