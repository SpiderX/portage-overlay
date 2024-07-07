# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Semantic versioning utilities, constraint parsing, and checking"
HOMEPAGE="https://github.com/composer/semver"
SRC_URI="https://github.com/composer/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader"
BDEPEND="dev-php/theseer-Autoload"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	phpab --quiet --output src/autoload.php \
		--template fedora2 --basedir src/ src \
		|| die "phpab failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Composer/Semver
	doins -r src/.
}
