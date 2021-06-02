# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
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

	distutils-r1_python_prepare_all
}
