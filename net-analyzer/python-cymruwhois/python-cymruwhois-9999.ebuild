# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/JustinAzoff/${PN}.git"

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="Python client for the whois.cymru.com service"
HOMEPAGE="https://github.com/JustinAzoff/python-cymruwhois"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
RESTRICT="test" # need network

distutils_enable_tests nose

pkg_postinst() {
	optfeature "cache support" dev-python/python-memcached
}
