# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://gitlab.common-lisp.net/rfc2109/${PN}.git"

inherit common-lisp-3 git-r3

DESCRIPTION="Common Lisp RFC2109 compliant cookies"
HOMEPAGE="https://gitlab.common-lisp.net/rfc2109/rfc2109"

LICENSE="BSD"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )" # pending-is-it-legal-or-illegal-cookie-string fails

RDEPEND="dev-lisp/split-sequence"
BDEPEND="dev-lisp/asdf
	test? ( dev-lisp/sbcl:*
		dev-lisp/fiveam )"

src_prepare() {
	default

	# correct system definition
	sed -i 's|rfc2109.test|rfc2109/test|' runner.lisp \
		|| die "sed failed for runner.lisp"
}

src_test() {
	einfo "Running test suite:"
	sbcl < runner.lisp || die "test failed"
}
