# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Executes commands in sub-processes"
HOMEPAGE="https://github.com/symfony/process"
EGIT_REPO_URI="https://github.com/symfony/process.git"

LICENSE="MIT"
SLOT="0"
IUSE="pcntl test"
REQUIRED_USE="test? ( pcntl )"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*[pcntl?]
	dev-php/fedora-autoloader"
BDEPEND="test? ( dev-php/phpunit )"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
}

src_test() {
	# skipped — testFind{BatchExecutable,BuiltInCommand}OnWindows,
	# testTTYInWindowsEnvironment, testPathResolutionOnWindows
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Component/Process
	doins -r Exception Messenger Pipes ./*.php
}
