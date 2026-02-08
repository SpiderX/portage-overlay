# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} python3_{13,14}t )

inherit distutils-r1 git-r3

DESCRIPTION="Mustache templating language renderer"
HOMEPAGE="https://github.com/noahmorrison/chevron"
EGIT_REPO_URI="https://github.com/noahmorrison/${PN}.git"

LICENSE="MIT"
SLOT="0"

python_test() {
	"${PYTHON}" test_spec.py || die "tests failed with ${EPYTHON}"
}
