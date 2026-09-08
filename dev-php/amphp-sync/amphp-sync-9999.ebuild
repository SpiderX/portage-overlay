# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Amp/Sync"
PHP_REQ_USE="sharedmem?,sysvipc?"

inherit composer git-r3

DESCRIPTION="Non-blocking synchronization primitives for PHP"
HOMEPAGE="https://github.com/amphp/sync"
EGIT_REPO_URI="https://github.com/amphp/sync.git"

LICENSE="MIT"
SLOT="0"
IUSE="sharedmem sysvipc"
REQUIRED_USE="test? ( sharedmem sysvipc )"

RDEPEND="dev-php/amphp-amp
	dev-php/amphp-pipeline
	dev-php/amphp-serialization
	dev-php/revolt-event-loop"

PATCHES=( "${FILESDIR}/${PN}"-2.3.0-tests-AbstractSemaphoreTest.patch
	"${FILESDIR}/${PN}"-2.3.0-tests-PriorityQueueTest.patch
	"${FILESDIR}/${PN}"-2.3.0-tests-RateLimitingSemaphoreTest.patch
	"${FILESDIR}/${PN}"-2.3.0-tests-phpunit.xml.patch )

composer_enable_tests phpunit
