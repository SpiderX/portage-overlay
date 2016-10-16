# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 python3_4 )

inherit qmake-utils python-single-r1 subversion

DESCRIPTION="A dynamic Python binding for the Qt framework"
HOMEPAGE="http://pythonqt.sourceforge.net/"
SRC_URI=""
ESVN_REPO_URI="https://pythonqt.svn.sourceforge.net/svnroot/pythonqt/trunk"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="doc examples +extensions tests webkit"
REQUIRED_USE="webkit? ( extensions ) ${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	extensions? (
		dev-qt/qtsvg:5
		dev-qt/qtsql:5
		dev-qt/qtnetwork:5
		dev-qt/qtxml:5
		dev-qt/qtxmlpatterns:5
		dev-qt/qtopengl:5
		dev-qt/qtprintsupport:5
		dev-qt/qtmultimedia:5[widgets]
		dev-qt/qtdeclarative:5[widgets]
		dev-qt/designer:5
	)
	webkit? ( dev-qt/qtwebkit:5 )
	"
DEPEND="${RDEPEND}
	!extensions? ( dev-qt/qtxml:5 )
	doc? ( app-doc/doxygen )
	virtual/pkgconfig"

S="${WORKDIR}/${PN}${PV}"

src_prepare() {
	if ! use extensions ; then
		sed -i 's/extensions//' ${PN}.pro || die "sed for extensions"
	fi
	if ! use tests ; then
		sed -i 's/tests//' ${PN}.pro || die "sed for tests"
	fi
	if ! use examples ; then
		sed -i 's/examples//' ${PN}.pro || die "sed for examples"
	fi
	if ! use webkit ; then
		# Remove webkit support if not used
		sed -i '/qtHaveModule(webkit):CONFIG += PythonQtWebKit/d' \
			extensions/PythonQt_QtAll/PythonQt_QtAll.pro \
			|| die "sed for webkit"
	fi

	# Set python version to use
	sed -i "s/unix:PYTHON_VERSION=2.7/unix:PYTHON_VERSION=${EPYTHON/#python/}/" \
		build/python.prf || die "sed for python version"

	default
}

src_configure() {
	eqmake5 PREFIX="${D}"/usr
}

src_install() {
	default

	# Includes
	insinto /usr/include/${PN}
	doins -r src/*.h
	insinto /usr/include/${PN}/gui
	doins -r src/gui/*.h

	exeinto /usr/lib/${PN}

	if tests ; then
		insinto /usr/include/${PN}/tests
		doins tests/PythonQtTests.h
		doexe lib/PythonQtTest
	fi

	if use extensions ; then
		insinto /usr/include/${PN}/extensions/${PN}_QtAll
		doins -r extensions/${PN}_QtAll/*.h
	fi

	if use examples ; then
		doexe lib/*Example
		doexe lib/PyGettingStarted
		doexe lib/PyGuiExample
		doexe lib/PyLauncher
		doexe lib/PyScriptingConsole
	fi

	# Library
	dolib.so lib/lib${PN}*
}
