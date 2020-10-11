# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/aws/${PN}.git"

inherit git-r3 go-module readme.gentoo-r1 systemd tmpfiles

DESCRIPTION="Amazon Cloudwatch Agent"
HOMEPAGE="https://github.com/aws/amazon-cloudwatch-agent"
SRC_URI=""

LICENSE="Apache-2.0 BSD BSD-2 ISC MIT MPL-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""
RESTRICT="test"

RDEPEND="acct-user/amazon
	acct-user/cwagent"

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
	# Don't build windows and don't strip
	sed -i  -e '/GOOS=windows/d' \
		-e '/LDFLAGS =/s/ -s//' \
		Makefile || die "sed failed for windows"

	if ! usex amd64 ; then
		sed -i '/GOARCH=amd64/d' Makefile || die "sed failed for amd64"
	fi
	if ! usex arm64 ; then
		sed -i '/GOARCH=arm64/d' Makefile || die "sed failed for arm64"
	fi
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
	systemd_dounit packaging/dependencies/amazon-cloudwatch-agent.service
	newtmpfiles "${FILESDIR}"/amazon.tmpfile amazon.conf
	newtmpfiles "${FILESDIR}"/amazon-cloudwatch-agent.tmpfile amazon-cloudwatch-agent.conf
}

pkg_postinst() {
	go-module_pkg_postinst

	readme.gentoo_print_elog
	tmpfiles_process amazon.conf
	tmpfiles_process amazon-cloudwatch-agent.conf
}
