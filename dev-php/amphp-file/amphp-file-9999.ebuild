# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMPOSER_INSTALL_PATH="Amp/File"

inherit composer git-r3 optfeature

DESCRIPTION="An abstraction layer and non-blocking file access solution"
HOMEPAGE="https://github.com/amphp/file"
EGIT_REPO_URI="https://github.com/amphp/file.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # needs composer

RDEPEND="dev-php/amphp-amp
	dev-php/amphp-byte-stream
	dev-php/amphp-cache
	dev-php/amphp-parallel
	dev-php/amphp-sync
	dev-php/revolt-event-loop"
BDEPEND="test? ( dev-php/pecl-eio
		dev-php/pecl-uv )"

composer_enable_tests phpunit

pkg_postinst() {
	optfeature "PHP extention with eio" dev-php/pecl-eio
	optfeature "PHP extention with parallel" dev-php/pecl-parallel
	optfeature "PHP extention with uv" dev-php/pecl-uv
}
