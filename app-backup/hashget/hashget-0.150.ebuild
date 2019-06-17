# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5..6} )

inherit distutils-r1 systemd

DESCRIPTION="Deduplication tool for archiving data with extremely high ratio"
HOMEPAGE="https://gitlab.com/yaroslaff/hashget"
SRC_URI="https://gitlab.com/yaroslaff/${PN}/-/archive/${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-arch/patool[${PYTHON_USEDEP}]
	dev-python/filelock[${PYTHON_USEDEP}]
	dev-python/filetype[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

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
