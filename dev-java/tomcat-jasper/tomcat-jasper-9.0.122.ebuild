# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Apache Tomcat Jasper JSP engine"
HOMEPAGE="https://tomcat.apache.org/"
SRC_URI="https://archive.apache.org/dist/tomcat/tomcat-9/v${PV}/src/apache-tomcat-${PV}-src.tar.gz"
S="${WORKDIR}/apache-tomcat-${PV}-src"

LICENSE="Apache-2.0"
SLOT="9"
KEYWORDS="~amd64"

CP_DEPEND="dev-java/eclipse-ecj:4.26
	dev-java/tomcat-embed-el:9
	dev-java/tomcat-util:9
	dev-java/tomcat-util-scan:9"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-11"
RDEPEND="${CP_DEPEND}
	>=virtual/jre-11"

# needs ant-core
JAVA_RM_FILES=( java/org/apache/jasper/compiler/AntCompiler.java
	java/org/apache/jasper/JspC.java )
JAVA_RESOURCE_DIRS="java/res"
JAVA_SRC_DIR="java/org/apache/jasper"

src_prepare() {
	java-pkg-2_src_prepare

	# preserve the upstream resource hierarchy (javax/servlet/...) under
	# ${JAVA_RESOURCE_DIRS} while avoiding an extra leading "java/" path component.
	edo mkdir -p "${JAVA_RESOURCE_DIRS}"/META-INF
	edo cp -r res/META-INF/jasper.jar/. "${JAVA_RESOURCE_DIRS[0]}"/META-INF
	edo cd java
	edo find "${JAVA_SRC_DIR#java/}" -type f -regex '.*\.\(properties\|xml\)$' \
		-exec cp --parents -v -t "${JAVA_RESOURCE_DIRS[0]#java/}" {} +
}
