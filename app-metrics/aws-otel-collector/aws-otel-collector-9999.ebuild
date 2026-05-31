# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module systemd tmpfiles

DESCRIPTION="Amazon AWS Opentelemetry Collector"
HOMEPAGE="https://github.com/aws-observability/aws-otel-collector"
EGIT_REPO_URI="https://github.com/aws-observability/${PN}.git"

LICENSE="Apache-2.0 BSD BSD-2 ISC MIT MPL-2.0"
SLOT="0"

RDEPEND="acct-group/amazon
	acct-group/aoc
	acct-user/amazon
	acct-user/aoc"
BDEPEND=">=dev-lang/go-1.26.2"

src_unpack() {
	git-r3_src_unpack
}

src_compile() {
	COMMIT="$(git rev-parse HEAD)"
	DATE="$(date -u +'%Y-%m-%dT%H:%M:%SZ')"
	LDFLAGS="-w -X \"github.com/aws-observability/aws-otel-collector/tools/version.Date=${DATE}\" \
		-X github.com/aws-observability/aws-otel-collector/tools/version.GitHash=${COMMIT} \
		-X github.com/aws-observability/aws-otel-collector/tools/version.Version=${PV}"
	GOFLAGS="-v -x -mod=vendor" ego build -ldflags="${LDFLAGS}" \
		-o aws-otel-collector ./cmd/awscollector
}

src_test() {
	GOFLAGS="-v -x -mod=vendor" ego test -work ./...
}

src_install() {
	einstalldocs

	diropts -o aoc -g aoc -m 0755
	keepdir /opt/aws/aws-otel-collector/{doc,etc,logs,var}

	insopts -o aoc -g aoc -m 0644
	insinto /opt/aws/aws-otel-collector/etc
	doins config.yaml extracfg.txt
	newins - .env <<-EOF
		config=--config /opt/aws/aws-otel-collector/etc/config.yaml
	EOF
	exeinto /opt/aws/aws-otel-collector/bin
	newexe tools/ctl/linux/aws-otel-collector-ctl.sh aws-otel-collector-ctl
	doexe aws-otel-collector
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
}

pkg_postinst() {
	go-module_pkg_postinst
	tmpfiles_process aws-otel-collector.conf
}
