# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/composer/semver.git"

inherit git-r3

DESCRIPTION="Tools for working with and validating SPDX licenses"
HOMEPAGE="https://github.com/composer/spdx-licenses"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="!dev-php/spdx-licenses
	dev-lang/php:*
	dev-php/fedora-autoloader"
BDEPEND="test? ( dev-php/phpunit )"

PATCHES=( "${FILESDIR}/${PN}"-1.5.8-res-path.patch )

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/autoload.php || die "install failed"
	# mimic system path for bootstrap
	mkdir -p composer tmp/fake || die "mkdir failed"
	ln -s -t composer ../res || die "ln for res failed"
	# remove test for non-existed class
	rm tests/SpdxLicensesUpdaterTest.php || die "rm failed"
	# fix function declaration and path to res
	sed -i  -e "/__DIR__/s|__DIR__ . '/../res|'${S}/res|" \
		-e '/setUp/s|$|: void|' tests/SpdxLicensesTest.php \
		|| die "sed failed for SpdxLicensesTest.php"
	# mimic system path for bootstrap
	cp -a src tests tmp/fake || die "cp failed"
}

src_test() {
	phpunit --bootstrap tmp/fake/src/autoload.php \
		tmp/fake/tests --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Composer/Spdx
	doins -r src/.
	insinto /usr/share/composer/res
	doins -r res/.
}
