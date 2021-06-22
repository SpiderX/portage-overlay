# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1 optfeature

DESCRIPTION="Python client for the whois.cymru.com service"
HOMEPAGE="https://github.com/JustinAzoff/python-cymruwhois"
SRC_URI="https://github.com/JustinAzoff/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # need network

distutils_enable_tests nose

pkg_postinst() {
	optfeature "cache support" dev-python/python-memcached
}
