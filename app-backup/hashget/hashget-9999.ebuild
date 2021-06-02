# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{8..10} )
EGIT_REPO_URI="https://github.com/yaroslaff/${PN}.git"

inherit distutils-r1 git-r3 systemd

DESCRIPTION="Deduplication tool for archiving data with extremely high ratio"
HOMEPAGE="https://github.com/yaroslaff/hashget"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="test"
RESTRICT="test" # requires infra to run

RDEPEND="app-arch/patool[${PYTHON_USEDEP}]
	dev-python/filelock[${PYTHON_USEDEP}]
	dev-python/filetype[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

distutils_enable_tests pytest

src_prepare() {
	default

	# Correct path
	sed -i '/ExecStart/s|local/||' hashget-admin.service \
		|| die "sed failed"
}

src_install() {
	einstalldocs
	distutils-r1_src_install

	newinitd "${FILESDIR}"/hashget-admin.initd hashget-admin
	newconfd "${FILESDIR}"/hashget-admin.confd hashget-admin
	systemd_dounit hashget-admin.service
}
