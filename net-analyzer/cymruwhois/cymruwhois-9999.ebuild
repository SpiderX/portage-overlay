# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="Python client for the whois.cymru.com service"
HOMEPAGE="https://github.com/JustinAzoff/python-cymruwhois"
EGIT_REPO_URI="https://github.com/JustinAzoff/${PN}.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # nose

pkg_postinst() {
	optfeature "cache support" dev-python/python-memcached
}
