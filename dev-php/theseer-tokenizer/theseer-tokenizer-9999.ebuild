# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="TheSeer/Tokenizer"
PHP_REQ_USE="xml,xmlwriter,tokenizer"

inherit composer git-r3

DESCRIPTION="Convert tokenized PHP source code into XML and other formats"
HOMEPAGE="https://github.com/theseer/tokenizer"
EGIT_REPO_URI="https://github.com/theseer/Autoload.git"

LICENSE="BSD"
SLOT="0"

BDEPEND="dev-php/theseer-Autoload"

DOCS=( {CHANGELOG,README}.md )

composer_enable_tests phpunit

src_prepare() {
	default

	edo phpab -q -o src/autoload.php -t fedora2 src
}
