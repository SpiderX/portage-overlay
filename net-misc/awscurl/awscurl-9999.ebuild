# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
EGIT_REPO_URI="https://github.com/okigan/${PN}.git"
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 git-r3

DESCRIPTION="Make signed requests to AWS API"
HOMEPAGE="https://github.com/okigan/awscurl"

LICENSE="MIT"
SLOT="0"
PROPERTIES="test_network"
RESTRICT="test"

RDEPEND="dev-python/configargparse[${PYTHON_USEDEP}]
	dev-python/configparser[${PYTHON_USEDEP}]
	dev-python/botocore[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/mock[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

export AWS_ACCESS_KEY_ID=MOCK_AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=MOCK_AWS_SECRET_ACCESS_KEY
export AWS_SESSION_TOKEN=MOCK_AWS_SESSION_TOKEN
