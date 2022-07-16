# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{8..11} )
EGIT_REPO_URI="https://github.com/mingrammer/${PN}.git"

inherit distutils-r1 git-r3

DESCRIPTION="Diagram as Code for prototyping cloud system architectures"
HOMEPAGE="https://github.com/mingrammer/diagrams"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-python/graphviz[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

python_prepare_all() {
	# Add backend specification and relax requirement
	sed -i  -e '1 i[build-system]\nrequires = ["poetry>=0.12"]\nbuild-backend = "poetry.core.masonry.api"' \
		-e '/graphviz/s|,<0.20.0||' \
		pyproject.toml || die "sed failed for pyproject.toml"

	distutils-r1_python_prepare_all
}
