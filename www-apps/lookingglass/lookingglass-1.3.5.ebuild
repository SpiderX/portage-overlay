# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit webapp

WEBAPP_MANUAL_SLOT="yes"

DESCRIPTION="Modern, simple and fresh looking glass based on Bootstrap 5 and PHP 8"
HOMEPAGE="https://github.com/hybula/lookingglass"
SRC_URI="https://github.com/hybula/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-lang/php:*"

src_install() {
	einstalldocs
	webapp_src_preinst

	insinto "${MY_HTDOCSDIR}"
	doins {LookingGlass,backend,bootstrap,config.dist,index}.php
	webapp_src_install
}
