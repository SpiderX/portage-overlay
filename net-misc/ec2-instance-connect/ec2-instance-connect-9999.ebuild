# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGIT_REPO_URI="https://github.com/aws/aws-ec2-instance-connect-config.git"

inherit git-r3 systemd

DESCRIPTION="AWS EC2 Instance Connect Configuration"
HOMEPAGE="https://github.com/aws/aws-ec2-instance-connect-config"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

RDEPEND="acct-user/ec2-instance-connect
	dev-libs/openssl:0=
	net-misc/curl
	net-misc/openssh"

src_prepare() {
	default

	# Adjust paths
	sed -i '/ExecStart/s|bin|ec2-instance-connect/bin|' \
		src/rpm_systemd/ec2-instance-connect.service \
		|| die "sed failed for ec2-instance-connect.service"
	sed -i '/ExecStart/s|/bin|/ec2-instance-connect/bin|' \
		src/rpm_systemd/sshd.service.d/ec2-instance-connect.conf \
		|| die "sed failed for ec2-instance-connect.conf"
}

src_test() {
	bin/unit_test_suite.sh || die "tests failed"
}

src_install() {
	exeinto /opt/aws/ec2-instance-connect/bin
	doexe src/bin/eic_{curl_authorized_,harvest_host,parse_authorized_,run_authorized_}keys

	dosym ../aws/ec2-instance-connect/bin/eic_curl_authorized_keys opt/bin/eic_curl_authorized_keys
	dosym ../aws/ec2-instance-connect/bin/eic_harvest_hostkeys opt/bin/eic_harvest_hostkeys
	dosym ../aws/ec2-instance-connect/bin/eic_parse_authorized_keys opt/bin/eic_parse_authorized_keys
	dosym ../aws/ec2-instance-connect/bin/eic_run_authorized_keys opt/bin/eic_run_authorized_keys

	systemd_dounit src/rpm_systemd/ec2-instance-connect.service
	insinto /lib/systemd/system/ssh.service.d
	doins src/rpm_systemd/sshd.service.d/ec2-instance-connect.conf
}
