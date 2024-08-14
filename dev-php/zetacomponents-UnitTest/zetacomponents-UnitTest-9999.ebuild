# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/zetacomponents/UnitTest.git"

inherit git-r3

DESCRIPTION="Unit tests for any Zeta component"
HOMEPAGE="https://github.com/zetacomponents/UnitTest"

LICENSE="Apache-2.0"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*"

src_prepare() {
	default

	# pre-generated autoload since this is revdep for phpab
	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/ezc/UnitTest
	doins -r src/.
}
