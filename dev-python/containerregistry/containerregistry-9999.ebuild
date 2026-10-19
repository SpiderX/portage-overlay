# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..15} )

inherit git-r3 python-r1

DESCRIPTION="Python libraries and tools for interacting with Docker registries"
HOMEPAGE="https://github.com/google/containerregistry"
EGIT_REPO_URI="https://github.com/google/containerregistry.git"

LICENSE="Apache-2.0"
SLOT="0"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	dev-python/httplib2[${PYTHON_USEDEP}]
	dev-python/oauth2client[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"

src_prepare() {
	default

	mkdir -p python-package/containerregistry || die
	cp -a {__init__.py,client,tools,transform,transport} \
		python-package/containerregistry/ || die
}

src_install() {
	python_foreach_impl python_domodule python-package/containerregistry
}
