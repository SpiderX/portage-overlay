# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
DISTUTILS_SINGLE_IMPL=Yes
MY_HOME="/var/lib/${PN}"

inherit distutils-r1 user systemd mercurial

DESCRIPTION="NOCProject supervisor"
HOMEPAGE="https://bitbucket.org/nocproject/noc-tower"
SRC_URI=""
EHG_REPO_URI="https://bitbucket.org/nocproject/noc-tower"

LICENSE="BSD"
IUSE="systemd"
SLOT="0"
KEYWORDS=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	dev-vcs/mercurial
	>=app-admin/ansible-2.0[${PYTHON_USEDEP}]
	dev-python/peewee[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	www-servers/tornado[${PYTHON_USEDEP}]
	dev-python/futures[${PYTHON_USEDEP}]
	dev-python/bcrypt[${PYTHON_USEDEP}]
	dev-python/jsmin[${PYTHON_USEDEP}]"

DOCS=( FAQ_rus.md Readme.md contrib/nginx/tower.conf )

pkg_setup() {
	python-single-r1_pkg_setup

	enewgroup noc
	enewuser noc -1 -1 "${MY_HOME}" noc
}

src_prepare() {
	# Fix path, change dir to noc-tower, remove unneeded script
	sed -i \
		-e s":var:${D}/var/lib:" \
		-e s':"tower", d):"noc-tower", d):' \
		-e '/scripts=/'d \
		setup.py || die "sed for setup.py failed"
	sed -i \
		-e s":var/tower:${MY_HOME}:" \
		tower/api/repo.py || die "sed for repo.py failed"
	sed -i \
		-e s":var/tower:${MY_HOME}:" \
		tower/cli/backup.py || die "sed for backup.py failed"
	sed -i \
		-e s":var/tower:${MY_HOME}:" \
		tower/models/crashinfo.py || die "sed for crashinfo.py failed"
	sed -i \
		-e s':./bin/hg:/usr/bin/hg:' \
		tower/api/pull.py || die "sed for pull.py failed"
	sed -i \
		-e s':"var":"/var/lib/":' \
		-e s':"tower":"noc-tower":' \
		tower/models/environment.py || die "sed for environment.py failed"
	sed -i \
		-e s':"bin":"/usr/bin":' \
		tower/api/deploy.py || die "sed for deploy.py failed"
	sed -i \
		-e s':"var":"/var/lib/":' \
		-e s':"tower":"noc-tower":' \
		tower/models/joblog.py || die "sed for joblog.py failed"

	# Change requirements to match portage stable versions
	sed -i \
		-e s':ansible==2.1.0.0:ansible>=2.0:' \
		-e s':peewee==2.8.0:peewee>=2.7:' \
		-e s':tornado==4.3:tornado>=4.2:' \
		-e s':bcrypt==2.0.0:bcrypt>=1.1.1:' \
		-e s':futures==3.0.3:futures>=3.0.3:' \
		requirements.txt || die "sed for requirements.txt failed"

	# Change path for cache
	sed -i -e s":var/tower:${MY_HOME}:" \
		tower/api/ui.py || die "sed for ui.py failed"
	# Change path for db
	sed -i -e s":../../../../../var/tower:${MY_HOME}:" \
		tower/models/db.py || die "sed for db.py failed"

	default
}

src_install() {
	distutils-r1_src_install

	keepdir "${MY_HOME}" /var/log/noc/
	fowners -R noc:noc "${MY_HOME}" /var/log/noc/

	newinitd "${FILESDIR}"/"${PN}".initd "${PN}"
	newconfd "${FILESDIR}"/"${PN}".confd "${PN}"
	systemd_dounit "${FILESDIR}"/"${PN}".service
}
