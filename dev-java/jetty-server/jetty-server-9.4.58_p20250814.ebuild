# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit java-pkg-2 java-pkg-simple

MY_PV="${PV//_p/.v}"

DESCRIPTION="HTTP server implementation for Eclipse Jetty"
HOMEPAGE="https://github.com/jetty/jetty.project"
SRC_URI="https://github.com/jetty/jetty.project/archive/jetty-${MY_PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/jetty.project-jetty-${MY_PV}"

LICENSE="EPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

CP_DEPEND="dev-java/javax-servlet-api:3.1
	dev-java/jetty-http:0
	dev-java/jetty-io:0"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-11"
RDEPEND="${CP_DEPEND}
	>=virtual/jre-11"

JAVA_RESOURCE_DIRS="jetty-server/src/main/resources"
JAVA_SRC_DIR="jetty-server/src/main/java"
