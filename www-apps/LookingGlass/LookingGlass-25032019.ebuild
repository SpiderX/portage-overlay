# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..12} )
WEBAPP_MANUAL_SLOT="yes"

inherit python-r1 webapp

COMMIT="a1db4790cb3bbd9ed95b3773208e50f8003488f8"

DESCRIPTION="A Python-backed Looking Glass"
HOMEPAGE="https://github.com/ramnode/LookingGlass"
SRC_URI="https://github.com/ramnode/${PN}/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="vhosts"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="dev-python/flask[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/markupsafe[${PYTHON_USEDEP}]
	dev-python/werkzeug[${PYTHON_USEDEP}]
	dev-python/itsdangerous[${PYTHON_USEDEP}]
	dev-python/sh[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	${PYTHON_DEPS}
	app-admin/webapp-config
	net-analyzer/mtr
	net-analyzer/traceroute
	net-dns/bind-tools"

src_install() {
	webapp_src_preinst

	insinto "${MY_HTDOCSDIR}"/instance
	doins instance/default.cfg
	insinto "${MY_HTDOCSDIR}"/templates
	doins templates/index.html
	insinto "${MY_HTDOCSDIR}"/static
	doins -r static/*
	insinto "${MY_HTDOCSDIR}"
	doins lookingglass.py

	webapp_src_install
	einstalldocs
}
