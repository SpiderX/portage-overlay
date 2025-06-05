# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="Microsoft Authentication Extensions for Python"
HOMEPAGE="https://github.com/AzureAD/microsoft-authentication-extensions-for-python"
EGIT_REPO_URI="https://github.com/AzureAD/microsoft-authentication-library-for-python.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test"

RDEPEND="dev-python/msal[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/pygobject[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

pkg_postinst() {
	optfeature "support of portalocker" dev-python/portalocker
}
