# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1 readme.gentoo-r1 systemd tmpfiles

MY_PV=$(ver_rs 3 '-')

DESCRIPTION="System and NGINX metric collection"
HOMEPAGE="https://amplify.nginx.com"
SRC_URI="https://github.com/nginxinc/${PN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

CDEPEND="dev-python/crossplane[${PYTHON_USEDEP}]
	dev-python/gevent[${PYTHON_USEDEP}]
	dev-python/netaddr[${PYTHON_USEDEP}]
	dev-python/netifaces[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/ujson[${PYTHON_USEDEP}]
	dev-python/pymysql[${PYTHON_USEDEP}]
	dev-python/python-daemon[${PYTHON_USEDEP}]
	dev-python/rstr[${PYTHON_USEDEP}]
	dev-python/flup[${PYTHON_USEDEP}]"
RDEPEND="${CDEPEND}
	www-servers/nginx[nginx_modules_http_stub_status]"
DEPEND="${CDEPEND}"
BDEPEND="test? ( dev-python/pyhamcrest[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/requests-mock[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${PN}-${MY_PV}"

distutils_enable_tests pytest

DOC_CONTENTS="You should put you API_KEY from https://amplify.nginx.com/
into api_key parameter in /etc/nginx-amplify-agent/agent.conf"

EPYTEST_DESELECT=(
	test/unit/agent/supervisor.py::SupervisorTestCase::test_filters_applying_oss
	test/unit/agent/supervisor.py::SupervisorTestCase::test_filters_unchanged
	test/unit/agent/collectors/nginx/config.py::ConfigCollectorTestCase::test_collect
	test/unit/agent/collectors/nginx/config.py::ConfigCollectorTestCase::test_skip_parse_until_change
	test/unit/agent/collectors/nginx/config.py::ConfigCollectorTestCase::test_test_run_time
	test/unit/agent/collectors/nginx/config.py::ConfigCollectorSSLTestCase::test_ssl_config_doesnt_work_if_ssl_disabled
	test/unit/agent/collectors/nginx/config.py::ConfigCollectorSSLTestCase::test_ssl_config_works_if_ssl_enabled
	test/unit/agent/common/util/ssl.py::SSLAnalysisTestCase::test_ssl_analysis
	test/unit/agent/managers/nginx.py::NginxManagerTestCase::test_find_all
	test/unit/agent/managers/nginx.py::NginxManagerTestCase::test_find_none
	test/unit/agent/managers/nginx.py::NginxManagerTestCase::test_reload
	test/unit/agent/collectors/system/meta.py::SystemMetaCollectorTestCase::test_default_interface
	test/unit/agent/collectors/system/metrics.py::SystemMetricsCollectorTestCase::test_collect
	test/unit/agent/objects/nginx/config/config.py::ConfigLogsTestCase::test_logs_path
	test/unit/agent/objects/nginx/config/config.py::ConfigTestCase::test_broken
	test/unit/agent/objects/nginx/config/config.py::ConfigTestCase::test_broken_includes
	test/unit/agent/objects/nginx/config/config.py::ConfigTestCase::test_parse_simple
	test/unit/agent/objects/nginx/config/config.py::ConfigTestCase::test_parse_wildcard_dir
	test/unit/agent/objects/nginx/config/config.py::ExcludeConfigTestCase::test_parse_simple_exclude_multiple
	test/unit/agent/objects/nginx/config/parser.py::ParserTestCase::test_lightweight_parse_includes
	test/unit/agent/objects/nginx/config/parser.py::ParserTestCase::test_lightweight_parse_includes_permissions
	test/unit/agent/objects/nginx/config/parser.py::ParserTestCase::test_parse_huge
	test/unit/agent/objects/nginx/config/parser.py::ParserTestCase::test_parse_ssl_include_dirs
	test/unit/agent/tanks/nginx_config.py::NginxConfigTankCleanTestCase::test_clean
	test/unit/agent/tanks/nginx_config.py::NginxConfigTankCleanTestCase::test_discover
	test/unit/agent/pipelines/syslog.py::SyslogTailTestCase::test_overall
	test/unit/ext/phpfpm/objects/master.py::PHPFPMObjectTestCase::test_parse
)

src_prepare() {
	default

	# remove zope reference, remove data files
	sed -i  -e '/amplify.zope/d' \
		-e '/        ]/a\    )),' \
		-e '/amplify-agent\//,+3d' \
		setup.py || die "sed failed for setup.py"
	rm test/unit/agent/collectors/nginx/meta.py \
		test/unit/agent/common/util/ps.py \
		test/unit/agent/collectors/nginx/metrics.py \
		test/unit/agent/managers/nginx.py \
		test/unit/agent/objects/nginx/object.py \
		test/unit/ext/mysql/managers.py \
		test/unit/ext/mysql/collectors/meta.py \
		test/unit/ext/mysql/collectors/metrics.py \
		test/unit/ext/phpfpm/util.py \
		test/unit/ext/phpfpm/collectors/master/meta.py \
		test/unit/ext/phpfpm/collectors/master/metrics.py \
		test/unit/ext/phpfpm/collectors/pool/metrics.py \
		test/unit/ext/phpfpm/managers/master.py \
		test/unit/ext/phpfpm/managers/pool.py || die "rm failed"
}

src_install() {
	distutils-r1_src_install

	newinitd "${FILESDIR}"/nginx-amplify-agent.initd nginx-amplify-agent
	newconfd "${FILESDIR}"/nginx-amplify-agent.initd nginx-amplify-agent
	systemd_dounit "${FILESDIR}"/nginx-amplify-agent.service
	newtmpfiles "${FILESDIR}"/nginx-amplify-agent.tmpfile nginx-amplify-agent.conf

	keepdir /var/log/nginx-amplify-agent /etc/nginx-amplify-agent
	fowners -R nginx:nginx /var/log/nginx-amplify-agent \
		/etc/nginx-amplify-agent
	insinto /etc/nginx-amplify-agent
	doins etc/agent.conf.default
	insinto /etc/logrotate.d
	newins etc/logrotate.d/amplify-agent nginx-amplify-agent

	readme.gentoo_create_doc
}

pkg_postinst() {
	tmpfiles_process nginx-amplify-agent.conf
	readme.gentoo_print_elog
}
