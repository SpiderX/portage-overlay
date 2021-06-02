# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="docker ps in colored and long output"
HOMEPAGE="https://github.com/politeauthority/docker-pretty-ps"
SRC_URI="https://github.com/politeauthority/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

distutils_enable_tests pytest

python_prepare_all() {
	# Don't install tests
	sed -i '/find_packages/s/)/exclude=["tests*"])/' setup.py \
		|| die "sed failed for setup.py"

	distutils-r1_python_prepare_all
}
