# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Unit tests for any Zeta component"
HOMEPAGE="https://github.com/zetacomponents/UnitTest"
EGIT_REPO_URI="https://github.com/zetacomponents/UnitTest.git"

LICENSE="Apache-2.0"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*"

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/ezc/UnitTest
	doins -r src/.
}
