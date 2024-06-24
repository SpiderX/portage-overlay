# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

COMMIT="b4aeddc5e6a0c7595502da47ea6383864faf90dc"

DESCRIPTION="Content Security Policy logs parser"
HOMEPAGE="https://github.com/yandex/csp-reporter"
SRC_URI="https://github.com/yandex/${PN}/archive/${COMMIT}.tar.gz -> ${P}.gh.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests

RDEPEND="dev-python/jinja[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

python_prepare_all() {
	# remove extension
	sed -i '/scripts/s|.py||' setup.py || die "sed failed for setup.py"
	mv csp-reporter{.py,} || die "mv failed for csp-reporter.py"

	distutils-r1_python_prepare_all
}

src_install() {
	einstalldocs
	insinto /etc/csp-reporter
	newins config.ini-sample config.ini

	distutils-r1_src_install
}
