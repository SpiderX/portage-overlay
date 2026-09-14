# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Apache Tomcat JULI logging implementation"
HOMEPAGE="https://tomcat.apache.org/"
SRC_URI="https://archive.apache.org/dist/tomcat/tomcat-9/v${PV}/src/apache-tomcat-${PV}-src.tar.gz"
S="${WORKDIR}/apache-tomcat-${PV}-src"

LICENSE="Apache-2.0"
SLOT="9"
KEYWORDS="~amd64"

DEPEND=">=virtual/jdk-11"
RDEPEND=">=virtual/jre-11"

PATCHES=( "${FILESDIR}/${PN}"-9.0.110-remove-bnd-annotation.patch )

JAVA_SRC_DIR="java/org/apache/juli"
