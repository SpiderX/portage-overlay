# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_SUBMODULES=()

inherit git-r3 go-module readme.gentoo-r1 systemd tmpfiles

DESCRIPTION="Amazon Cloudwatch Agent"
HOMEPAGE="https://github.com/aws/amazon-cloudwatch-agent"
EGIT_REPO_URI="https://github.com/aws/${PN}.git"

LICENSE="Apache-2.0 BSD BSD-2 ISC MIT MPL-2.0"
SLOT="0"
IUSE="otel"
RESTRICT="test"

RDEPEND="acct-user/amazon
	acct-user/cwagent
	otel? ( app-metrics/aws-otel-collector[cwagent] )"

DOCS=( README.md RELEASE_NOTES )

DOC_CONTENTS="For new configuration run:
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-config-wizard
This will create config.json, move it into config directory:
mv /opt/aws/amazon-cloudwatch-agent/bin/config.json \
/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_prepare() {
	default

	# Define version for build
	echo "${PV}" > CWAGENT_VERSION || die "echo failed"
	# Don't build windows and macos, otel and don't strip
	sed -i  -e "/\$(WIN_BUILD)/d" \
		-e "/0 GOOS=windows GOARCH=amd64/d" \
		-e "/\$(DARWIN_BUILD)/d" \
		-e "/build: /s/cwagent-otel-collector //" \
		-e "/LDFLAGS =/s/ -s//" \
		Makefile || die "sed failed for windows"
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
		build/bin/linux_"$(usex amd64 amd64 arm64)"/start-amazon-cloudwatch-agent
	# This is needed for amazon-cloudwatch-agent-ctl
	insinto /opt/aws/amazon-cloudwatch-agent/bin
	doins CWAGENT_VERSION

	dosym ../../opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
		usr/bin/amazon-cloudwatch-agent-ctl
	dosym ../../opt/aws/amazon-cloudwatch-agent/etc etc/amazon/amazon-cloudwatch-agent
	dosym ../../../opt/aws/amazon-cloudwatch-agent/logs var/log/amazon/amazon-cloudwatch-agent

	newinitd "${FILESDIR}"/amazon-cloudwatch-agent.initd amazon-cloudwatch-agent
	newconfd "${FILESDIR}"/amazon-cloudwatch-agent.confd amazon-cloudwatch-agent
	newinitd "${FILESDIR}"/amazon-cloudwatch-otel.initd amazon-cloudwatch-otel
	newconfd "${FILESDIR}"/amazon-cloudwatch-otel.confd amazon-cloudwatch-otel
	systemd_dounit packaging/dependencies/{amazon-cloudwatch-agent,cwagent-otel-collector}.service
	newtmpfiles "${FILESDIR}"/amazon-cloudwatch-agent.tmpfile amazon-cloudwatch-agent.conf
}

pkg_postinst() {
	go-module_pkg_postinst

	readme.gentoo_print_elog
	tmpfiles_process amazon-cloudwatch-agent.conf
}
