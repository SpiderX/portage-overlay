# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Protocol Buffer bindings for dbt"
HOMEPAGE="https://github.com/dbt-labs/proto-python-public"
EGIT_REPO_URI="https://github.com/dbt-labs/proto-python-public.git"

LICENSE="Apache-2.0"
SLOT="0"

RDEPEND="dev-python/protobuf[${PYTHON_USEDEP}]"

python_prepare_all() {
	# don't install tests
	sed -i '/find_namespace_packages/s/)/exclude=["test"])/' setup.py \
		|| die "sed failed for setup.py"

	distutils-r1_python_prepare_all
}
