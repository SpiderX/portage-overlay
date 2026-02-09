# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )

inherit edo git-r3 qmake-utils python-single-r1 virtualx

DESCRIPTION="A dynamic Python binding for the Qt framework"
HOMEPAGE="https://mevislab.github.io/pythonqt/"
EGIT_REPO_URI="https://github.com/MeVisLab/${PN}.git"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="debug doc examples +extensions test"
REQUIRED_USE="${PYTHON_REQUIRED_USE} test? ( extensions ) examples? ( extensions )"
RESTRICT="!test? ( test )"

RDEPEND="${PYTHON_DEPS}
	dev-qt/qt5compat:6
	dev-qt/qtbase:6[gui,network,widgets,xml]
	extensions? (
		dev-qt/qtdeclarative:6[widgets]
		dev-qt/qtmultimedia:6
		dev-qt/qtpositioning:6
		dev-qt/qtscxml:6
		dev-qt/qtsvg:6
		dev-qt/qtwebchannel:6 )"
DEPEND="${RDEPEND}
	doc? ( app-text/doxygen )"
BDEPEND="app-arch/unzip
	virtual/pkgconfig"

src_prepare() {
	default

	if ! use examples ; then
		sed -i '/SUBDIRS/s/ examples//' PythonQt.pro || die "sed for examples"
	fi
	if ! use extensions ; then
		sed -i '/SUBDIRS/s/ extensions//' PythonQt.pro || die "sed for extensions"
	fi
	if ! use test ; then
		sed -i '/SUBDIRS/s/ tests//' PythonQt.pro || die "sed for test"
	fi
	# remove webkit support
	sed -i '/qtHaveModule(webkit):CONFIG += PythonQtWebKit/d' \
		extensions/PythonQt_QtAll/PythonQt_QtAll.pro \
		|| die "sed for webkit"
}

src_configure() {
	edo pushd generator
	eqmake6 CONFIG+="$(usex debug debug release '' '')"
	edo popd
	eqmake6 PYTHON_DIR="/usr" PYTHON_VERSION="${EPYTHON/python}" \
		CONFIG+="$(usex debug debug release '' '')" CONFIG+=exclude_generator \
		PREFIX="${EPREFIX}"/usr
	if use test ; then
		# create empty dir to pass check in common.prf
		edo mkdir generated_cpp_610
		edo pushd tests
		eqmake6 PYTHON_DIR="/usr" PYTHON_VERSION="${EPYTHON/python}" \
			CONFIG+="$(usex debug debug release '' '')"
		edo popd
		edo rmdir generated_cpp_610
	fi
}

src_compile() {
	edo pushd generator
	emake
	# QTDIR is here just to suppress warning, second path helps generator
	# to determine QT version from qtcoreversion.h
	QTDIR=/usr edo ./pythonqt_generator --include-paths=/usr/include/qt6:/usr/include/qt6/QtCore
	edo popd
	emake
}

src_test() {
	virtx ./lib/PythonQtTest"$(usex debug _d '' '' '')"
}

src_install() {
	einstalldocs

	# Includes
	insinto /usr/include/PythonQt
	doins -r src/*.h
	insinto /usr/include/PythonQt/gui
	doins -r src/gui/*.h

	if use extensions ; then
		insinto /usr/include/PythonQt/extensions/PythonQt_QtAll
		doins -r extensions/PythonQt_QtAll/*.h
	fi

	# Libraries
	dolib.so lib/libPythonQt*
}
