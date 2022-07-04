# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1 optfeature

DESCRIPTION="An enterprise friendly way of detecting and preventing secrets"
HOMEPAGE="https://github.com/Yelp/detect-secrets"
SRC_URI="https://github.com/Yelp/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # fails

RDEPEND="dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"
BDEPEND="test? ( dev-vcs/git
		dev-python/ahocorasick[${PYTHON_USEDEP}]
		dev-util/gibberish-detector[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

python_prepare_all() {
	if use test ; then
		git init > /dev/null || die "git init failed"
		git config --global user.email "${PN}@gentoo.org" || die "git config failed"
		git config --global user.name "${PN}" || die "git config failed"
	fi
	distutils-r1_python_prepare_all
}

pkg_postinst() {
	optfeature "integration with Aho-Corasick search" dev-python/ahocorasick
	optfeature "integration with gibberish detector" dev-util/gibberish-detector
}
