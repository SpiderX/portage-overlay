# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit git-r3

DESCRIPTION="A language agnostic test suite for the JSON Schema specifications"
HOMEPAGE="https://github.com/json-schema-org/JSON-Schema-Test-Suite"
EGIT_REPO_URI="https://github.com/json-schema-org/JSON-Schema-Test-Suite.git"

LICENSE="MIT"
SLOT="0"

src_install() {
	einstalldocs
	insinto /usr/share/php/json-schema-test-suite
	doins -r .
}
