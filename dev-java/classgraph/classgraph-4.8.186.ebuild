# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="An uber-fast parallelized Java classpath scanner and module scanner"
HOMEPAGE="https://github.com/classgraph/classgraph"
SRC_URI="https://github.com/${PN}/${PN}/archive/${P}.tar.gz"
S="${WORKDIR}/${PN}-${P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=virtual/jdk-11"
RDEPEND=">=virtual/jre-11"

JAVA_SRC_DIR="src/main/java"
