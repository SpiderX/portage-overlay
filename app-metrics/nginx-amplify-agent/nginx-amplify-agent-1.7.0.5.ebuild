# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 readme.gentoo-r1 systemd tmpfiles

MY_PV=$(ver_rs 3 '-')

DESCRIPTION="System and NGINX metric collection"
HOMEPAGE="https://amplify.nginx.com"
SRC_URI="https://github.com/nginxinc/${PN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="test"

CDEPEND="dev-python/crossplane[${PYTHON_USEDEP}]
	>=dev-python/gevent-1.2.1[${PYTHON_USEDEP}]
	dev-python/lockfile[${PYTHON_USEDEP}]
	dev-python/netaddr[${PYTHON_USEDEP}]
	dev-python/netifaces[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/ujson[${PYTHON_USEDEP}]
	dev-python/pymysql[${PYTHON_USEDEP}]
	dev-python/python-daemon[${PYTHON_USEDEP}]
	dev-python/pyparsing[${PYTHON_USEDEP}]
	dev-python/setproctitle[${PYTHON_USEDEP}]
	dev-python/rstr[${PYTHON_USEDEP}]
	dev-python/flup[${PYTHON_USEDEP}]
	dev-python/scandir[${PYTHON_USEDEP}]"
RDEPEND="${CDEPEND}
	app-admin/logrotate
	www-servers/nginx[nginx_modules_http_stub_status]"
DEPEND="${CDEPEND}"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pyhamcrest[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/requests-mock[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${PN}-${MY_PV}"

DOC_CONTENTS="You should put you API_KEY from https://amplify.nginx.com/
into api_key parameter in /etc/nginx-amplify-agent/agent.conf"

src_prepare() {
	default

	# Make paths more logical
	sed -i '/\/amplify-agent/s|amplify-agent|nginx-amplify-agent|' \
		setup.py || die "sed failed for setup.py"
	mv etc/logrotate.d/{amplify-agent,nginx-amplify-agent} \
		|| die "logrotate renaming failed"
	# Remove tests that require nginx+
	rm test/unit/agent/collectors/plus/{slab,cache,meta,status_zone,stream,stream_upstream,upstream}.py \
		|| die "tests removing failed"
}

python_install_all() {
	distutils-r1_python_install_all

	newinitd "${FILESDIR}"/nginx-amplify-agent.initd nginx-amplify-agent
	newconfd "${FILESDIR}"/nginx-amplify-agent.initd nginx-amplify-agent
	systemd_dounit "${FILESDIR}"/nginx-amplify-agent.service
	newtmpfiles "${FILESDIR}"/nginx-amplify-agent.tmpfile nginx-amplify-agent.conf

	keepdir /var/log/nginx-amplify-agent/
	fowners -R nginx:nginx /var/log/nginx-amplify-agent \
		/etc/nginx-amplify-agent/

	readme.gentoo_create_doc
}

pkg_postinst() {
	tmpfiles_process nginx-amplify-agent.conf
	readme.gentoo_print_elog
}
