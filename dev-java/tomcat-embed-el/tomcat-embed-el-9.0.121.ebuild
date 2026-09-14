# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Apache Tomcat embedded Expression Language engine"
HOMEPAGE="https://tomcat.apache.org/"
SRC_URI="https://archive.apache.org/dist/tomcat/tomcat-9/v${PV}/src/apache-tomcat-${PV}-src.tar.gz"
S="${WORKDIR}/apache-tomcat-${PV}-src"

LICENSE="Apache-2.0"
SLOT="9"
KEYWORDS="~amd64"

CP_DEPEND="dev-java/tomcat-el-api:3.0"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-11"
RDEPEND="${CP_DEPEND}
	>=virtual/jre-11"

PATCHES=( "${FILESDIR}/${PN}"-9.0.110-remove-bnd-annotation.patch )

JAVA_RESOURCE_DIRS="java/res"
JAVA_SRC_DIR=( java/org/apache/el java/javax/el )

src_prepare() {
	java-pkg-2_src_prepare

	# preserve the upstream resource hierarchy (javax/servlet/...) under
	# ${JAVA_RESOURCE_DIRS} while avoiding an extra leading "java/" path component.
	edo mkdir -p "${JAVA_RESOURCE_DIRS}"/META-INF/native-image/org.apache.tomcat.embed/tomcat-embed-el
	edo cp -r res/META-INF/jasper-el.jar/. "${JAVA_RESOURCE_DIRS[0]}"/META-INF
	edo cp -r res/graal/tomcat-embed-el/native-image/{reflect,resource}-config.json \
		"${JAVA_RESOURCE_DIRS}"/META-INF/native-image/org.apache.tomcat.embed/tomcat-embed-el
	edo cd java
	edo find "${JAVA_SRC_DIR#java/}" -type f -regex '.*\.\(properties\|jjt\)$' \
		-exec cp --parents -v -t "${JAVA_RESOURCE_DIRS[0]#java/}" {} +
	edo find "${JAVA_SRC_DIR[1]#java/}" -type f -name '*.properties' \
		-exec cp --parents -v -t "${JAVA_RESOURCE_DIRS[0]#java/}" {} +
}
