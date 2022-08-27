# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )
EGIT_REPO_URI="https://github.com/politeauthority/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="docker ps in colored and long output"
HOMEPAGE="https://github.com/politeauthority/docker-pretty-ps"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

distutils_enable_tests pytest

python_prepare_all() {
	# Don't install tests
	sed -i '/find_packages/s/)/exclude=["tests*"])/' setup.py \
		|| die "sed failed for setup.py"
	# fix QA
	sed -i '/description/s/-/_/' setup.cfg || die "sed failed for setup.cfg"

	distutils-r1_python_prepare_all
}
