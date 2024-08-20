# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/symfony/polyfill-uuid.git"

inherit git-r3 optfeature

DESCRIPTION="Symfony polyfill for uuid functions"
HOMEPAGE="https://github.com/symfony/polyfill-uuid"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Polyfill/Uuid
	doins -r "${FILESDIR}"/autoload.php ./*.php
}

pkg_postinst() {
	optfeature "Support of best performance" dev-php/pecl-uuid
}
