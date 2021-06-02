# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1 systemd

DESCRIPTION="Deduplication tool for archiving data with extremely high ratio"
HOMEPAGE="https://gitlab.com/yaroslaff/hashget"
SRC_URI="https://github.com/yaroslaff/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="app-arch/patool[${PYTHON_USEDEP}]
	dev-python/filelock[${PYTHON_USEDEP}]
	dev-python/filetype[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

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
