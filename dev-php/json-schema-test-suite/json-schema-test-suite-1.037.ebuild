# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

MY_PN="Test-JSON-Schema-Acceptance"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A language agnostic test suite for the JSON Schema specifications"
HOMEPAGE="https://github.com/json-schema-org/JSON-Schema-Test-Suite"
SRC_URI="https://github.com/json-schema-org/JSON-Schema-Test-Suite/archive/${MY_P}.tar.gz"
S="${WORKDIR}/JSON-Schema-Test-Suite-${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_install() {
	einstalldocs
	insinto /usr/share/php/json-schema-test-suite
	doins -r .
}
