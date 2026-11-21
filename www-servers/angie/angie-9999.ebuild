# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2016

EAPI=8

GENTOO_DEPEND_ON_PERL="no"
PYTHON_COMPAT=( python3_{12..15} )

inherit edo git-r3 multiprocessing python-any-r1 toolchain-funcs perl-functions systemd tmpfiles

ANGIE_MODULES_HTTP_STD="access api auth_basic autoindex browser charset docker empty_gif
	fastcgi geo grpc gzip limit_req limit_conn map memcached mirror
	prometheus proxy referer rewrite scgi ssi split_clients upstream_hash
	upstream_ip_hash upstream_keepalive upstream_least_conn upstream_random
	upstream_sticky upstream_zone userid uwsgi"
ANGIE_MODULES_HTTP_OPT="acme addition auth_request dav degradation flv geoip gunzip
	gzip_static image_filter mp4 perl random_index realip secure_link
	slice stub_status sub xslt"
ANGIE_MODULES_STREAM_STD="access geo limit_conn map pass return set split_clients
	upstream_hash upstream_least_conn upstream_random upstream_sticky upstream_zone"
ANGIE_MODULES_STREAM_OPT="acme geoip mqtt_preread rdp_preread realip ssl_preread"
ANGIE_MODULES_MAIL="imap pop3 smtp"

DESCRIPTION="Efficient, powerful and scalable reverse proxy and web server"
HOMEPAGE="https://github.com/webserver-llc/angie"
EGIT_REPO_URI="https://github.com/webserver-llc/${PN}.git"

LICENSE="BSD-2"
SLOT="0/${PV}"
IUSE="aio debug +http +http2 http3 +http-cache ipv6 libatomic mail pcre pcre2 pcre-jit selinux
	ssl stream test threads vim-syntax"

for mod in $ANGIE_MODULES_HTTP_STD ; do IUSE="${IUSE} +angie-modules-http-${mod//_/-}" ; done
for mod in $ANGIE_MODULES_HTTP_OPT ; do IUSE="${IUSE} angie-modules-http-${mod//_/-}" ; done
for mod in $ANGIE_MODULES_STREAM_STD ; do IUSE="${IUSE} angie-modules-stream-${mod//_/-}" ; done
for mod in $ANGIE_MODULES_STREAM_OPT ; do IUSE="${IUSE} angie-modules-stream-${mod//_/-}" ; done
for mod in $ANGIE_MODULES_MAIL ; do IUSE="${IUSE} angie-modules-mail-${mod}" ; done

REQUIRED_USE="?? ( pcre pcre2 )
	http? ( angie-modules-http-rewrite? ( || ( pcre pcre2 ) )
		angie-modules-http-acme? ( ssl ) )
	http2? ( http )
	http3? ( http ssl )
	http-cache? ( http )
	pcre-jit? ( || ( pcre pcre2 ) )
	stream? ( angie-modules-stream-acme? ( angie-modules-http-acme http ) )
	test? ( angie-modules-http-addition angie-modules-http-auth-basic angie-modules-http-auth-request
		angie-modules-http-dav angie-modules-http-flv angie-modules-http-geoip angie-modules-http-gunzip
		angie-modules-http-gzip-static angie-modules-http-image-filter angie-modules-http-mp4
		angie-modules-http-perl angie-modules-http-random-index angie-modules-http-secure-link
		angie-modules-http-slice angie-modules-http-stub-status angie-modules-http-sub
		angie-modules-http-uwsgi angie-modules-http-xslt angie-modules-mail-imap angie-modules-mail-pop3
		angie-modules-mail-smtp angie-modules-stream-access angie-modules-stream-acme
		angie-modules-stream-geo angie-modules-stream-geoip angie-modules-stream-limit-conn
		angie-modules-stream-map angie-modules-stream-mqtt-preread angie-modules-stream-pass
		angie-modules-stream-rdp-preread angie-modules-stream-realip angie-modules-stream-return
		angie-modules-stream-set angie-modules-stream-split-clients
		angie-modules-stream-upstream-hash angie-modules-stream-upstream-least-conn
		angie-modules-stream-upstream-random angie-modules-stream-upstream-sticky
		angie-modules-stream-upstream-zone angie-modules-stream-ssl-preread debug http http3 mail stream )"
RESTRICT="test"
PROPERTIES="test_network"

CDEPEND="acct-group/angie
	acct-user/angie
	virtual/libcrypt:=
	pcre? ( dev-libs/libpcre:= )
	pcre2? ( dev-libs/libpcre2:= )
	ssl? ( dev-libs/openssl:0= )
	http? ( angie-modules-http-geoip? ( dev-libs/geoip )
		angie-modules-http-gunzip? ( virtual/zlib:0= )
		angie-modules-http-gzip? ( virtual/zlib:0= )
		angie-modules-http-image-filter? ( media-libs/gd:=[jpeg,png] )
		angie-modules-http-perl? ( >=dev-lang/perl-5.8:= )
		angie-modules-http-secure-link? ( dev-libs/openssl:0= )
		angie-modules-http-xslt? ( dev-libs/libxml2:= dev-libs/libxslt ) )
	stream? ( angie-modules-stream-geoip? ( dev-libs/geoip ) )"
RDEPEND="${CDEPEND}
	>=app-misc/mime-types-2.1.54-r1[angie]
	selinux? ( sec-policy/selinux-nginx )
	!www-servers/nginx:mainline"
IDEPEND="virtual/tmpfiles"
DEPEND="${CDEPEND}
	libatomic? ( dev-libs/libatomic_ops )"
BDEPEND="test? ( dev-lang/perl
		dev-perl/Cache-Memcached
		dev-perl/Cache-Memcached-Fast
		dev-perl/CryptX
		dev-perl/FCGI
		dev-perl/GD
		dev-perl/IO-Socket-SSL
		dev-perl/JSON
		dev-perl/Protocol-WebSocket
		dev-perl/SCGI
		dev-perl/Test-Deep
		dev-perl/Test-Most
		dev-perl/TimeDate
		media-libs/gd[webp]
		media-video/ffmpeg[x264]
		net-dns/bind
		net-dns/dnsmasq
		net-misc/memcached
		$(python_gen_any_dep 'www-servers/uwsgi[python,ssl,${PYTHON_USEDEP}]') )"

PDEPEND="vim-syntax? ( app-vim/nginx-syntax )"

DOCS=( CHANGES README.rst )

PATCHES=( "${FILESDIR}/${PN}-httpoxy-mitigation-r1.patch" )

pkg_setup() {
	use test && python-any-r1_pkg_setup
}

src_prepare() {
	default

	# don't rename etc files, remove useless files
	sed -i  -e 's/.default//' \
		-e '/koi-/d' \
		-e '/win-/d' \
		-e '/$NGX_HTML/d' \
		-e '/NGX_PREFIX\/html/d' \
		-e '/"\$NGX_PID_PATH/d' \
		auto/install || die "sed failed for install"

	# don't install to /etc/angie/ if not in use
	local module
	for module in fastcgi scgi uwsgi ; do
		if ! use angie-modules-http-${module}; then
			sed -i -e "/${module}/d" auto/install \
				|| die "sed failed for auto/install"
		fi
	done

	# decrease path to unix socket api.sock for tests
	sed -i '/"angie-/s|ngie-test|-|' tests/lib/Test/Nginx.pm || die "sed failed for Nginx.pm"
	# remove tests require ipv6
	if ! use ipv6 ; then
		eapply "${FILESDIR}/${PN}"-1.12.5-tests-no-ipv6.patch
		edo rm tests/{http_resolver_aaaa,stream_access}.t
		edo rm tests/{geo,proxy_protocol,stream_geo,stream_proxy_protocol,upstream_ip_hash}_ipv6.t
	fi
	# specify python plugin version only when test enabled
	if use test ; then
		sed -i "/push @uwsgiopts/s|python3|${EPYTHON/./}|" \
			tests/uwsgi{,_body,_ssl,_ssl_verify}.t || die "sed failed for uwsgi"
	fi
}

src_configure() {
	local myconf=()

	use aio       && myconf+=( --with-file-aio )
	use debug     && myconf+=( --with-debug )
	use http2     && myconf+=( --with-http_v2_module )
	use http3     && myconf+=( --with-http_v3_module )
	use libatomic && myconf+=( --with-libatomic )
	use pcre      && myconf+=( --without-pcre2 )
	use pcre-jit  && myconf+=( --with-pcre-jit )
	use threads   && myconf+=( --with-threads )

	use pcre || use pcre2 || myconf+=( --without-pcre )

	# HTTP modules
	for mod in $ANGIE_MODULES_HTTP_STD ; do
		use "angie-modules-http-${mod//_/-}" \
			|| myconf+=( --without-http_"${mod}"_module )
	done

	for mod in $ANGIE_MODULES_HTTP_OPT ; do
		use http && use "angie-modules-http-${mod//_/-}" \
			&& myconf+=( --with-http_"${mod}"_module )
	done

	if use http ; then
		use http-cache || myconf+=( --without-http-cache )
		use ssl && myconf+=( --with-http_ssl_module )
	else
		myconf+=( --without-http --without-http-cache )
	fi

	# Stream modules
	for mod in $ANGIE_MODULES_STREAM_STD ; do
		use "angie-modules-stream-${mod//_/-}" \
			|| myconf+=( --without-stream_"${mod}"_module )
	done

	for mod in $ANGIE_MODULES_STREAM_OPT ; do
		use stream && use "angie-modules-stream-${mod//_/-}" \
			&& myconf+=( --with-stream_"${mod}"_module )
	done

	if use stream ; then
		myconf+=( --with-stream )
		use ssl && myconf+=( --with-stream_ssl_module )
	fi

	# MAIL modules
	for mod in $ANGIE_MODULES_MAIL ; do
		use angie-modules-mail-"${mod}" \
			|| myconf+=( --without-mail_"${mod}"_module )
	done

	if use mail ; then
		myconf+=( --with-mail )
		use ssl && myconf+=( --with-mail_ssl_module )
	fi

	# https://bugs.gentoo.org/286772
	export LANG=C LC_ALL=C
	tc-export AR CC

	if ! use prefix ; then
		myconf+=( --user=angie )
		myconf+=( --group=angie )
	fi

	# econf?
	edo ./configure --with-compat \
		--prefix="${EPREFIX}"/usr \
		--conf-path="${EPREFIX}"/etc/angie/angie.conf \
		--error-log-path="${EPREFIX}"/var/log/angie/error_log \
		--pid-path="${EPREFIX}"/run/angie/angie.pid \
		--lock-path="${EPREFIX}"/run/lock/"${PN}".lock \
		--with-cc-opt="-I${ESYSROOT}/usr/include" \
		--with-ld-opt="-L${ESYSROOT}/usr/$(get_libdir)" \
		--http-log-path="${EPREFIX}"/var/log/angie/access_log \
		--http-acme-client-path="${EPREFIX}"/etc/angie/acme_client \
		--http-client-body-temp-path="${EPREFIX}"/var/cache/angie/client \
		--http-proxy-temp-path="${EPREFIX}"/var/cache/angie/proxy \
		--http-fastcgi-temp-path="${EPREFIX}"/var/cache/angie/fastcgi \
		--http-scgi-temp-path="${EPREFIX}"/var/cache/angie/scgi \
		--http-uwsgi-temp-path="${EPREFIX}"/var/cache/angie/uwsgi \
		"${myconf[@]}"

	# a purely cosmetic change that makes angie -V more readable. This can be
	# good if people outside the gentoo community would troubleshoot and
	# question the users setup.
	sed -i "s|${WORKDIR}|external_module|g" objs/ngx_auto_config.h \
		|| die "sed failed for ngx_auto_config.h"
}

src_test() {
	edo prove -v -j "$(makeopts_jobs)" tests
}

src_compile() {
	# https://bugs.gentoo.org/286772
	export LANG=C LC_ALL=C
	# set the correct installation directories for the Perl-related files
	PERL_MM_OPT='INSTALLDIRS=vendor' emake LINK="${CC} ${LDFLAGS}" OTHERLDFLAGS="${LDFLAGS}"
}

src_install() {
	emake DESTDIR="${D}" install

	insinto /etc/angie
	doins "${FILESDIR}"/angie.conf
	newinitd "${FILESDIR}"/angie.initd angie
	newconfd "${FILESDIR}"/angie.confd angie
	systemd_dounit "${FILESDIR}"/angie.service
	doman man/angie.8
	insinto /etc/logrotate.d
	newins "${FILESDIR}"/angie.logrotate angie
	newtmpfiles "${FILESDIR}"/angie.tmpfile angie.conf

	keepdir /var/www/localhost /var/log/angie
	fperms 0710 /var/log/angie
	fowners root:angie /var/log/angie

	if use http && use angie-modules-http-perl ; then
		perl_delete_module_manpages
		perl_delete_localpod
		perl_fix_packlist
	fi
}

pkg_postinst() {
	tmpfiles_process angie.conf
}
