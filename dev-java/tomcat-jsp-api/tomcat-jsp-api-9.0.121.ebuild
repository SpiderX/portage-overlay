# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Apache Tomcat JSP API"
HOMEPAGE="https://tomcat.apache.org/"
SRC_URI="https://archive.apache.org/dist/tomcat/tomcat-9/v${PV}/src/apache-tomcat-${PV}-src.tar.gz"
S="${WORKDIR}/apache-tomcat-${PV}-src"

LICENSE="Apache-2.0"
SLOT="2.3"
KEYWORDS="~amd64"

CP_DEPEND="dev-java/tomcat-el-api:3.0
	dev-java/tomcat-servlet-api:4.0"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-11"
RDEPEND="${CP_DEPEND}
	>=virtual/jre-11"

JAVA_RESOURCE_DIRS="java/res"
JAVA_SRC_DIR="java/javax/servlet/jsp"

src_prepare() {
	java-pkg-2_src_prepare

	# preserve the upstream resource hierarchy (javax/servlet/...) under
	# ${JAVA_RESOURCE_DIRS} while avoiding an extra leading "java/" path component.
	edo mkdir -p "${JAVA_RESOURCE_DIRS}"
	edo cd java
	edo find "${JAVA_SRC_DIR#java/}" -type f -regex '.*\.\(dtd\|xsd\)$' \
		-exec cp --parents -v -t "${JAVA_RESOURCE_DIRS[0]#java/}" {} +
}
