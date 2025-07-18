# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 git-r3

DESCRIPTION="Content Security Policy logs parser"
HOMEPAGE="https://github.com/yandex/csp-reporter"
EGIT_REPO_URI="https://github.com/yandex/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-python/jinja2[${PYTHON_USEDEP}]"
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
