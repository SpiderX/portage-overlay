# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12,13} )

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="Brings async, event-driven capabilities to Django"
HOMEPAGE="https://github.com/django/channels"
EGIT_REPO_URI="https://github.com/django/${PN}.git"

LICENSE="BSD"
SLOT="0"

RDEPEND="dev-python/asgiref[${PYTHON_USEDEP}]
	dev-python/django[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-python/async-timeout[${PYTHON_USEDEP}]
		dev-python/daphne[${PYTHON_USEDEP}]
		dev-python/selenium[${PYTHON_USEDEP}]
		dev-util/selenium-manager
		www-apps/chromedriver-bin )"

EPYTEST_PLUGINS=( pytest-{asyncio,django} )
distutils_enable_tests pytest

src_prepare() {
	default

	# don't install tests
	sed -i '/tests$/s|$|*|' setup.cfg || die "sed failed for setup.cfg"
}

pkg_postinst() {
	optfeature "integration with daphne" dev-python/daphne
}
