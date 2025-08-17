# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )
WEBAPP_MANUAL_SLOT="yes"
inherit git-r3 python-r1 webapp

DESCRIPTION="A Python-backed Looking Glass"
HOMEPAGE="https://github.com/ramnode/LookingGlass"
EGIT_REPO_URI="https://github.com/ramnode/${PN}.git"

LICENSE="MIT"
SLOT="0"
IUSE="vhosts"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="dev-python/flask[${PYTHON_USEDEP}]
	dev-python/jinja2[${PYTHON_USEDEP}]
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
