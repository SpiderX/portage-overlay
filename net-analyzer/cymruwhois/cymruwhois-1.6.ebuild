# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 optfeature pypi

DESCRIPTION="Python client for the whois.cymru.com service"
HOMEPAGE="https://github.com/JustinAzoff/python-cymruwhois"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # nose

pkg_postinst() {
	optfeature "cache support" dev-python/python-memcached
}
