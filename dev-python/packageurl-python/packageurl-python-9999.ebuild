# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} python3_{13,14}t )
EGIT_SUBMODULES=()

inherit distutils-r1 edo git-r3

DESCRIPTION="Python implementation of the package url spec"
HOMEPAGE="https://github.com/package-url/packageurl-python"
EGIT_REPO_URI="https://github.com/package-url/${PN}.git"

LICENSE="MIT"
SLOT="0"

distutils_enable_tests pytest

EPYTEST_IGNORE=(
	spec
)

python_prepare_all() {
	edo mkdir -p spec/tests/{types,spec}
	edo echo '{"tests":[]}' > spec/tests/spec/specification-test.json
	distutils-r1_python_prepare_all
}
