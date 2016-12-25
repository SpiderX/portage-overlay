# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit git-r3 webapp

WEBAPP_MANUAL_SLOT="yes"

DESCRIPTION="The worlds best and hottest interface to interact with aria2"
HOMEPAGE="https://github.com/ziahamza/${PN}"
EGIT_REPO_URI="https://github.com/ziahamza/${PN}.git"
SRC_URI=""

LICENSE="MIT"
SLOT=0
KEYWORDS=""
IUSE="vhosts"
DOCS=( README.md directurl.md )
DEPEND="${WEBAPP_DEPEND}"
RDEPEND="${DEPEND}"

src_install() {
	webapp_src_preinst

	# Fix permissions
	fperms 0644 index.html \
	css/bootstrap.css css/download.css css/modals.css css/style.css \
	img/*.png \
	js/init.js js/ctrls/main.js \
	js/libs/angularui-bootstrap.js js/libs/jquery-2.1.3.js \
	js/libs/jquery.flot.js js/libs/jquery.flot.resize.js \
	js/libs/jquery.flot.time.js js/libs/mustache.js js/libs/require.js \
	js/translate/it_IT.js

	cp -R css flags fonts img js index.html configuration.js favicon.ico \
	"${ED%/}"/"${MY_HTDOCSDIR}" || die "cp failed"

	webapp_configfile "${MY_HTDOCSDIR}"/configuration.js
	webapp_src_install
}
