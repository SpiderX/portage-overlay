# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=pyproject.toml
PYTHON_COMPAT=( python3_{6..8} )

inherit distutils-r1

DESCRIPTION="Minimal declarative cli tool"
HOMEPAGE="https://github.com/Woile/decli"
SRC_URI="https://github.com/Woile/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

distutils_enable_tests pytest

python_prepare_all() {
	# Add backend specification
	sed -i '1 i[build-system]\nrequires = ["poetry>=0.12"]\nbuild-backend = "poetry.masonry.api"' \
		pyproject.toml || die "sed failed for pyproject.toml"

	distutils-r1_python_prepare_all
}
