# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
DISTUTILS_SINGLE_IMPL=Yes
EGIT_REPO_URI="https://code.getnoc.com/noc/tower.git"

inherit distutils-r1 git-r3 user systemd tmpfiles

DESCRIPTION="NOCProject supervisor"
HOMEPAGE="https://code.getnoc.com/noc/tower/"
SRC_URI=""

LICENSE="BSD-4"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	app-admin/ansible[${PYTHON_USEDEP}]
	dev-python/appdirs[${PYTHON_USEDEP}]
	dev-python/bcrypt[${PYTHON_USEDEP}]
	dev-python/certifi[${PYTHON_USEDEP}]
	dev-python/cffi:=[${PYTHON_USEDEP}]
	dev-python/jmespath[${PYTHON_USEDEP}]
	dev-python/netaddr[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/paramiko[${PYTHON_USEDEP}]
	dev-python/peewee[${PYTHON_USEDEP}]
	dev-python/pycparser[${PYTHON_USEDEP}]
	dev-python/pyparsing[${PYTHON_USEDEP}]
	dev-python/singledispatch[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	www-servers/tornado[${PYTHON_USEDEP}]
	virtual/python-futures[${PYTHON_USEDEP}]"

DOCS=( FAQ_rus.md Readme.md contrib/nginx/tower.conf )

pkg_setup() {
	python-single-r1_pkg_setup

	enewgroup noc
	enewuser noc -1 -1 /var/lib/noc-tower noc
}

src_prepare() {
	default

	# Change path for data, don't install VERSION and script
	sed -i -e '/os.path.join/s|self.prefix, ||' \
		-e '/data_files/d' \
		-e '/scripts=/d' \
		setup.py || "sed failed for setup.py"
}

src_install() {
	distutils-r1_src_install

	keepdir /var/lib/noc-tower /var/log/noc/
	fowners -R noc:noc /var/lib/noc-tower /var/log/noc/

	newinitd "${FILESDIR}"/noc-tower.initd noc-tower
	newconfd "${FILESDIR}"/noc-tower.confd noc-tower
	systemd_dounit "${FILESDIR}"/noc-tower.service
	newtmpfiles "${FILESDIR}"/noc-tower.tmpfile noc-tower.conf
}

pkg_postinst() {
	tmpfiles_process noc-tower.conf
}
