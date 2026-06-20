# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CARGO_OPTIONAL=1
CRATES=""
LLVM_COMPAT=( {16..22} )
PYTHON_COMPAT=( python3_{12..15} )
RUST_MIN_VER="1.86.0"
USE_RUBY="ruby32 ruby33 ruby34"

inherit cargo edo flag-o-matic java-pkg-opt-2 llvm-r2 python-single-r1 readme.gentoo-r1 \
	ruby-single systemd toolchain-funcs

declare -a JARS=(
	"classgraph-4.8.181:/usr/share/classgraph/lib/classgraph.jar"
	"ecj-3.26.0:/usr/share/eclipse-ecj-4.26/lib/ecj.jar"
	"jetty-http-9.4.58.v20250814:/usr/share/jetty-http/lib/jetty-http.jar"
	"jetty-server-9.4.58.v20250814:/usr/share/jetty-server/lib/jetty-server.jar"
	"jetty-util-9.4.58.v20250814:/usr/share/jetty-util/lib/jetty-util.jar"
	"tomcat-api-9.0.110:/usr/share/tomcat-api-9/lib/tomcat-api.jar"
	"tomcat-jasper-9.0.110:/usr/share/tomcat-jasper-9/lib/tomcat-jasper.jar"
	"tomcat-jasper-el-9.0.110:/usr/share/tomcat-jasper-el-9/lib/tomcat-jasper-el.jar"
	"tomcat-jsp-api-9.0.110:/usr/share/tomcat-jsp-api-2.3/lib/tomcat-jsp-api.jar"
	"tomcat-juli-9.0.110:/usr/share/tomcat-juli-9/lib/tomcat-juli.jar"
	"tomcat-util-9.0.110:/usr/share/tomcat-util-9/lib/tomcat-util.jar"
	"tomcat-util-scan-9.0.110:/usr/share/tomcat-util-scan-9/lib/tomcat-util-scan.jar"
	"tomcat-servlet-api-9.0.110:/usr/share/tomcat-servlet-api-4.0/lib/tomcat-servlet-api.jar"
	"tomcat-el-api-9.0.110:/usr/share/tomcat-el-api-3.0/lib/tomcat-el-api.jar"
)

DESCRIPTION="Dynamic web and application server"
HOMEPAGE="https://github.com/freeunitorg/freeunit"
SRC_URI="https://github.com/freeunitorg/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-crates.tar.xz"

LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD CDLA-Permissive-2.0 ISC MIT Unicode-3.0 ZLIB"
SLOT="0"
KEYWORDS="~amd64"
IUSE="brotli debug go ipv6 java njs nodejs pcre perl php8-3 php8-4 php8-5 otlp +python +regex ruby ssl test threads tools wasm zlib zstd"
REQUIRED_USE="|| ( perl php8-3 php8-4 php8-5 python ruby )
	njs? ( ssl )
	otlp? ( ssl )
	pcre? ( regex )
	python? ( ${PYTHON_REQUIRED_USE} )"
RESTRICT="!test? ( test )"

CDEPEND="${PYTHON_DEPS}"
CP_DEPEND="dev-java/classgraph:0
	dev-java/eclipse-ecj:4.26
	dev-java/jetty-http:0
	dev-java/jetty-server:0
	dev-java/jetty-util:0
	dev-java/tomcat-api:9
	dev-java/tomcat-el-api:3.0
	dev-java/tomcat-jasper:9
	dev-java/tomcat-jasper-el:9
	dev-java/tomcat-jsp-api:2.3
	dev-java/tomcat-juli
	dev-java/tomcat-servlet-api:4.0
	dev-java/tomcat-util:9
	dev-java/tomcat-util-scan:9"
DEPEND="virtual/libcrypt:0=
	go? ( dev-lang/go:0= )
	java? ( ${CP_DEPEND}
		>=virtual/jdk-11:= )
	njs? ( dev-libs/njs:= )
	nodejs? ( ${CDEPEND}
		net-libs/nodejs:=[npm] )
	perl? ( dev-lang/perl:= )
	php8-3? ( dev-lang/php:8.3=[embed,threads?] )
	php8-4? ( dev-lang/php:8.4=[embed,threads?] )
	php8-5? ( dev-lang/php:8.5=[embed,threads?] )
	python? ( ${CDEPEND} )
	ruby? ( ${RUBY_DEPS} )
	ssl? ( dev-libs/openssl:0= )"
RDEPEND="${DEPEND}
	acct-user/freeunit
	acct-group/freeunit
	java? ( ${CP_DEPEND}
		>=virtual/jre-11:= )"
BDEPEND="sys-apps/which
	virtual/pkgconfig
	otlp? ( ${RUST_DEPEND} )
	wasm? ( ${RUST_DEPEND}
		$(llvm_gen_dep 'llvm-core/clang:${LLVM_SLOT}') )
	test? ( ${CDEPEND}
		$(python_gen_cond_dep 'dev-python/pyopenssl[${PYTHON_USEDEP}]' python3_{12..14})
		ruby? ( dev-ruby/rack
			dev-ruby/securerandom ) )"

PATCHES=( "${FILESDIR}/${PN}"-1.35.5-cflags.patch
	"${FILESDIR}/${PN}"-1.35.5-configure.patch )

DOCS=( CHANGES {EOL,README}.md )

DOC_CONTENTS="This package does not install the unitctl command-line client.\\n
If you need the unitctl utility, install app-admin/unitctl-bin\\n\\n"

EPYTEST_PLUGINS=()
EPYTEST_DESELECT=(
	# sigterm
	test/test_perl_application.py::test_perl_application_threads
	# flacky
	test/test_respawn.py::test_respawn_router
)

pkg_setup() {
	use java && java-pkg-opt-2_pkg_setup
	use python && python-single-r1_pkg_setup
	use otlp || use wasm || use test && rust_pkg_setup
	use wasm && llvm-r2_pkg_setup
}

src_unpack() {
	default
	use otlp || use wasm || use test && cargo_src_unpack

	if use java ; then
		local jar

		edo mkdir "${S}"/build
		for jar in "${JARS[@]}" ; do
			# system jars are copied instead of symlinked because the test suite
			# recursively chmods the build tree and follows symlinks
			edo cp -L "${jar#*:}" "${S}/build/${jar%%:*}.jar"
			sed -i "/${jar%%:*}\.jar/s|^.* |$(sha512sum "${jar#*:}" | cut -d' ' -f1)  |" \
				"${S}"/auto/modules/java_jar.sha512 || die "sed failed for java_jar.sha512"
		done
	fi
}

src_prepare() {
	default

	# npm versions reject --unsafe-perm and ignore it, so drop it from the upstream install
	sed -i 's/ --unsafe-perm//' auto/modules/nodejs || die "sed failed for nodejs"
	sed -i "/FAKE_UPSTREAM_BIN/s|/usr/local/bin|${S}/test/fake_upstream/target/debug|" \
		test/test_proxy_chunked.py || die "sed failed"
}

src_configure() {
	# configure script uses them (auto/make)
	AR="$(tc-getAR)"
	CC="$(tc-getCC)"
	export AR CC

	econf --cc="$(tc-getCC)" \
		--control=unix:/run/freeunit.sock \
		--group=freeunit \
		--ld-opt="${LDFLAGS}" \
		--libdir="${EPREFIX}"/usr/"$(get_libdir)" \
		--logdir=/var/log/freeunit \
		--log=/var/log/freeunit/freeunit.log \
		--modulesdir="${EPREFIX}"/usr/"$(get_libdir)"/freeunit \
		--pid=/run/freeunit.pid \
		--prefix="${EPREFIX}"/usr \
		--statedir=/var/lib/freeunit \
		--user=freeunit \
		"$(usex brotli --brotli --no-brotli)" \
		"$(usex debug --debug --no-debug)" \
		"$(usex ipv6 ipv6 --no-ipv6)" \
		"$(usex njs --njs --no-njs)" \
		"$(usex otlp --otel --no-otel)" \
		"$(usex pcre pcre --no-pcre2)" \
		"$(usex regex regex --no-regex)" \
		"$(usex ssl --openssl --no-openssl)" \
		"$(usex zlib --zlib --no-zlib)" \
		"$(usex zstd --zstd --no-zstd)"

	# runtime modules are loaded with dlopen(), therefore they must be built with PIC
	append-cflags "$(test-flags-CC -fPIC -Wno-incompatible-pointer-types)"

	use go && export CGO_CFLAGS_ALLOW='.*' CGO_LDFLAGS_ALLOW='.*'

	# node-gyp needs access to Unit headers and libunit from the build tree
	use nodejs && export npm_config_nodedir=/usr \
		CXXFLAGS="${CXXFLAGS} -I${S}/src -I${S}/build/include" \
		LDFLAGS="${LDFLAGS} -L${S}/build/lib"

	if use wasm ; then
		for ldflag in ${LDFLAGS} ; do RUSTFLAGS+=" -C link-arg=${ldflag}" ; done
		export RUSTFLAGS
	fi

	# each module is configured separately after the core configuration
	use go     && edo ./configure go --go-path=/usr/lib/go
	use java   && edo ./configure java
	use nodejs && edo ./configure nodejs --node-gyp=/usr/"$(get_libdir)"/node_modules/npm/bin/node-gyp-bin/node-gyp
	use perl   && edo ./configure perl
	use python && edo ./configure python
	use ruby   && edo ./configure ruby
	use wasm   && edo ./configure wasm-wasi-component

	local FLAG PHP
	for FLAG in php8-3 php8-4 php8-5 ; do
		PHP="/usr/$(get_libdir)/${FLAG/-/.}"
		use "${FLAG}" && edo ./configure php --module="${FLAG}" \
				--config="${PHP}"/bin/php-config \
				--lib-path="${PHP}"/"$(get_libdir)"
	done
}

src_compile() {
	default
	use test && cargo_src_compile --manifest-path test/fake_upstream/Cargo.toml
}

src_test() {
	# skip IPv6-specific tests
	use !ipv6 && \
	EPYTEST_DESELECT=(
		test/test_access_log.py::test_access_log_ipv6
		test/test_asgi_application.py::test_asgi_application_ipv6
		test/test_proxy.py::test_proxy_ipv6
		test/test_upstreams_rr.py::test_upstreams_rr_ipv6
		test/test_unix_abstract.py::test_unix_abstract_client_ip
		test/test_variables.py::test_variables_request_uri
		test/test_variables.py::test_variables_remote_addr
		test/test_client_ip.py::test_client_ip_single_ip
		test/test_client_ip.py::test_client_ip_ipv4
		test/test_client_ip.py::test_client_ip_ipv6
		test/test_client_ip.py::test_client_ip_unix
		test/test_client_ip.py::test_client_ip_recursive
		test/test_client_ip.py::test_client_ip_case_insensitive
		test/test_client_ip.py::test_client_ip_empty_source
		test/test_unix_abstract.py::test_unix_abstract_source
		test/test_configuration.py::test_listeners_addr
		test/test_forwarded_header.py::test_forwarded_header_single_ip
		test/test_forwarded_header.py::test_forwarded_header_ipv4
		test/test_forwarded_header.py::test_forwarded_header_ipv6
		test/test_forwarded_header.py::test_forwarded_header_recursive
		test/test_forwarded_header.py::test_forwarded_header_case_insensitive
		test/test_forwarded_header.py::test_forwarded_header_source_empty
		test/test_forwarded_header.py::test_forwarded_header_source_range
		test/test_configuration.py::test_listeners_port_release
		test/test_routing.py::test_routes_source_addr
		test/test_routing.py::test_routes_source_ipv6
		test/test_routing.py::test_routes_source_cidr
		test/test_routing.py::test_routes_source_cidr_ipv6
		test/test_routing.py::test_routes_source_unix
		test/test_routing.py::test_routes_match_source
		test/test_perl_application.py::test_perl_application_threads
	)
	epytest
}

src_install() {
	default
	readme.gentoo_create_doc

	if use java ; then
		edo rm -rf "${ED}"/usr/"$(get_libdir)"/freeunit/*.jar
		java-pkg_jarinto /usr/share/freeunit/lib
		java-pkg_dojar build/{nginx-unit-jsc,websocket-api}-java-"${PV}".jar
	fi

	use tools && dobin tools/unitc

	diropts -m 0770
	keepdir /var/{lib,log}/freeunit
	newinitd "${FILESDIR}"/freeunit.initd freeunit
	newconfd "${FILESDIR}"/freeunit.confd freeunit
	systemd_dounit "${FILESDIR}"/freeunit.service
	insinto /etc/logrotate.d
	newins "${FILESDIR}"/freeunit.logrotate freeunit
}

pkg_postinst() {
	readme.gentoo_print_elog
}
