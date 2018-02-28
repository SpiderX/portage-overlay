# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGIT_REPO_URI="https://github.com/andreif/${PN}.git"
EGIT_BRANCH="allthethings"
PYTHON_COMPAT=( python2_7 )

inherit git-r3 python-r1

DESCRIPTION="A high-performance PostgreSQL tuning script"
HOMEPAGE="https://github.com/andreif/pgtune https://github.com/gregs1104/pgtune"
SRC_URI=""

LICENSE="BSD-2"
KEYWORDS=""
SLOT="0"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}"

src_prepare() {
	default

	# Change settings directory default path
	sed -i '/settings_dir/s/default=None/default="\/usr\/share\/pgtune"/' \
		"${PN}" || die "sed failed"
}

src_install() {
	python_foreach_impl python_doscript "${PN}"
	insinto /usr/share/"${PN}"
	doins pg_settings-{9.1,9.3,9.4,9.5,9.6}-64
}
