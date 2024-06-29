# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )
EGIT_REPO_URI="https://github.com/RIPE-NCC/${PN}.git"

inherit distutils-r1 git-r3 optfeature

DESCRIPTION="A parsing library for RIPE Atlas measurement results"
HOMEPAGE="https://github.com/RIPE-NCC/ripe-atlas-sagan"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]"

DOCS=( {CHANGES,README}.rst )

distutils_enable_sphinx docs
#distutils_enable_tests nose

python_prepare_all() {
	sed -i '/ripe.atlas.sagan/s/"]/", "ripe.atlas.sagan.helpers"]/' setup.py \
		|| die "sed failed"
	distutils-r1_python_prepare_all
}

python_install_all() {
	rm -rf "ripe/__pycache__" "ripe/atlas/__pycache__" || die
	distutils-r1_python_install_all
}

pkg_postinst() {
	optfeature "fast json processing" dev-python/ujson
}
