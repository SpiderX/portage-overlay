# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module systemd tmpfiles

DESCRIPTION="Amazon AWS Opentelemetry Collector"
HOMEPAGE="https://github.com/aws-observability/aws-otel-collector"
EGIT_REPO_URI="https://github.com/aws-observability/${PN}.git"

LICENSE="Apache-2.0 BSD BSD-2 ISC MIT MPL-2.0"
SLOT="0"
IUSE="cwagent"
RESTRICT="test" # fails

RDEPEND="acct-user/amazon
	acct-user/aoc
	cwagent? ( acct-user/cwagent )"

src_unpack() {
	git-r3_src_unpack
	go-module_live_vendor
}

src_prepare() {
	default

	# Don't build windows and macos, don't strip
	sed -i  -e "/GOOS=windows GOARCH=amd64/d" \
		-e "/GOOS=darwin GOARCH=amd64/d" \
		-e "/build: install/s/ install-tools lint//" \
		-e "/LDFLAGS=/s/-s //" \
		Makefile || die "sed failed for Makefile"
}

src_compile() {
	emake build
	if use cwagent ; then
		AOC_IMPORT_PATH=github.com/aws-observability/aws-otel-collector
		AOC_LDFLAGS="-w -X ${AOC_IMPORT_PATH}/tools/version.GitHash=${COMMIT}
		-X github.com/open-telemetry/opentelemetry-collector-contrib/exporter/awsxrayexporter.collectorDistribution=cwagent-otel-collector
		-X github.com/open-telemetry/opentelemetry-collector-contrib/exporter/awsemfexporter.collectorDistribution=cwagent-otel-collector
		-X ${AOC_IMPORT_PATH}/tools/version.Version=v${PV}
		-X ${AOC_IMPORT_PATH}/tools/version.Date=$(date -u +%Y-%m-%dT%H:%M:%SZ)
		-X ${AOC_IMPORT_PATH}/pkg/userutils.defaultUser=cwagent
		-X ${AOC_IMPORT_PATH}/pkg/userutils.defaultInstallPath=/opt/aws/amazon-cloudwatch-agent/cwagent-otel-collector/
		-X ${AOC_IMPORT_PATH}/pkg/logger.UnixLogPath=/opt/aws/amazon-cloudwatch-agent/cwagent-otel-collector/logs/cwagent-otel-collector.log
		-X ${AOC_IMPORT_PATH}/pkg/extraconfig.unixExtraConfigPath=/opt/aws/amazon-cloudwatch-agent/cwagent-otel-collector/etc/extracfg.txt"
		go build -ldflags="${AOC_LDFLAGS}" -o build/linux/cwagent-otel-collector \
			./cmd/awscollector || die "go build failed"
	fi
}

src_install() {
	einstalldocs

	diropts -o aoc -g aoc -m 0755
	keepdir /opt/aws/aws-otel-collector/{doc,etc,logs,var}

	insopts -o aoc -g aoc -m 0644
	insinto /opt/aws/aws-otel-collector/etc
	doins config.yaml
	newins - .env <<-EOF
		config=--config /opt/aws/aws-otel-collector/etc/config.yaml
	EOF
	exeinto /opt/aws/aws-otel-collector/bin
	doexe tools/ctl/linux/aws-otel-collector-ctl
	newexe build/linux/aoc_linux_"$(usex amd64 x86_64 aarch64)" \
		aws-otel-collector
	# This is needed for aws-otel-collector-ctl
	insinto /opt/aws/aws-otel-collector/bin
	doins VERSION

	dosym ../../opt/aws/aws-otel-collector/bin/aws-otel-collector-ctl \
		usr/bin/aws-otel-collector-ctl
	dosym ../../opt/aws/aws-otel-collector/etc etc/amazon/aws-otel-collector
	dosym ../../../opt/aws/aws-otel-collector/logs \
		var/log/amazon/aws-otel-collector

	newinitd "${FILESDIR}"/aws-otel-collector.initd aws-otel-collector
	newconfd "${FILESDIR}"/aws-otel-collector.confd aws-otel-collector
	systemd_dounit tools/packaging/linux/aws-otel-collector.service
	newtmpfiles "${FILESDIR}"/aws-otel-collector.tmpfile aws-otel-collector.conf

	if use cwagent ; then
		diropts -o cwagent -g cwagent -m 0755
		keepdir /opt/aws/amazon-cloudwatch-agent/cwagent-otel-collector/{logs,var}
		dodir /opt/aws/amazon-cloudwatch-agent/cwagent-otel-collector/etc/cwagent-otel-collector.d

		insopts -o cwagent -g cwagent -m 0644
		# Make config the same as in deb package
		insinto /opt/aws/amazon-cloudwatch-agent/cwagent-otel-collector/var
		newins config.yaml .predefined-config-data
		# Make config for systemd unit
		insinto /opt/aws/amazon-cloudwatch-agent/cwagent-otel-collector/etc
		newins config.yaml cwagent-otel-collector.yaml
		exeinto /opt/aws/amazon-cloudwatch-agent/bin
		doexe build/linux/cwagent-otel-collector

		dosym ../../opt/aws/amazon-cloudwatch-agent/cwagent-otel-collector/etc \
			etc/amazon/cwagent-otel-collector
		dosym ../../../opt/aws/amazon-cloudwatch-agent/cwagent-otel-collector/logs \
			var/log/amazon/cwagent-otel-collector
		newtmpfiles "${FILESDIR}"/cwagent-otel-collector.tmpfile cwagent-otel-collector.conf
	fi
}

pkg_postinst() {
	go-module_pkg_postinst

	tmpfiles_process aws-otel-collector.conf
	use cwagent && tmpfiles_process cwagent-otel-collector.conf
}
