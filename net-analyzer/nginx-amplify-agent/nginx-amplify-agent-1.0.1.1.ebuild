# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit eutils distutils-r1 readme.gentoo-r1 systemd tmpfiles versionator

MY_PV=$(replace_version_separator 3 '-')

DESCRIPTION="System and NGINX metric collection"
HOMEPAGE="https://amplify.nginx.com"
SRC_URI="https://github.com/nginxinc/${PN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

CDEPEND="dev-python/crossplane[${PYTHON_USEDEP}]
	>=dev-python/gevent-1.2.1[${PYTHON_USEDEP}]
	dev-python/lockfile[${PYTHON_USEDEP}]
	dev-python/netaddr[${PYTHON_USEDEP}]
	dev-python/netifaces[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/ujson[${PYTHON_USEDEP}]
	dev-python/python-daemon[${PYTHON_USEDEP}]
	dev-python/pyparsing[${PYTHON_USEDEP}]
	dev-python/setproctitle[${PYTHON_USEDEP}]
	dev-python/rstr[${PYTHON_USEDEP}]
	dev-python/flup[${PYTHON_USEDEP}]
	dev-python/scandir[${PYTHON_USEDEP}]"
RDEPEND="${CDEPEND}
	app-admin/logrotate
	www-servers/nginx[nginx_modules_http_stub_status]"
DEPEND="${CDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/pyhamcrest[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/requests-mock[${PYTHON_USEDEP}]
	)"

S="${WORKDIR}/${PN}-${MY_PV}"

DOC_CONTENTS="You should put you API_KEY from https://amplify.nginx.com/
into api_key parameter in /etc/amplify-agent/agent.conf"

python_install_all() {
	distutils-r1_python_install_all

	newinitd "${FILESDIR}"/nginx-amplify-agent.initd nginx-amplify-agent
	newconfd "${FILESDIR}"/nginx-amplify-agent.initd nginx-amplify-agent
	systemd_dounit "${FILESDIR}"/nginx-amplify-agent.service
	newtmpfiles "${FILESDIR}"/nginx-amplify-agent.tmpfile amplify-agent.conf

	keepdir /var/log/amplify-agent/
	fowners -R nginx:nginx /var/log/amplify-agent \
		/etc/amplify-agent/

	readme.gentoo_create_doc
}

pkg_postinst() {
	tmpfiles_process amplify-agent.conf
	readme.gentoo_print_elog
}
