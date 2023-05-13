# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10,11} )
EGIT_REPO_URI="https://github.com/Woile/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Minimal declarative cli tool"
HOMEPAGE="https://github.com/Woile/decli"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

distutils_enable_tests pytest

python_prepare_all() {
	# Add backend specification
	sed -i '1 i[build-system]\nrequires = ["poetry>=0.12"]\nbuild-backend = "poetry.core.masonry.api"' \
		pyproject.toml || die "sed failed for pyproject.toml"

	distutils-r1_python_prepare_all
}
