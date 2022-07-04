# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/Netflix-Skunkworks/${PN}.git"
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1 git-r3

DESCRIPTION="Parse and Process AWS IAM Policies, Statements, ARNs"
HOMEPAGE="https://github.com/Netflix-Skunkworks/policyuniverse"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

distutils_enable_tests pytest

python_prepare_all() {
	# Fix QA
	sed -i '/description/s/-/_/' setup.cfg || die "sed failed"
	distutils-r1_python_prepare_all
}
