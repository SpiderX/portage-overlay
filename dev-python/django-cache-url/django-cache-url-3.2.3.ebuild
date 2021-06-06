# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

COMMIT="3480e70bb19eef22f4e1beeddd236f44414ac5ac"

DESCRIPTION="URL based cache backend configuration in Django"
HOMEPAGE="https://github.com/epicserve/django-cache-url"
SRC_URI="https://github.com/epicserve/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/django[${PYTHON_USEDEP}]"

S="${WORKDIR}/${PN}-${COMMIT}"

distutils_enable_tests pytest

python_prepare_all() {
	sed -i '/addopts/,+7d' setup.cfg || die "sed failed for setup.cfg"

	distutils-r1_python_prepare_all
}
