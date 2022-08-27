# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1 pax-utils

DESCRIPTION="IBM Cloud Developer Tools"
HOMEPAGE="https://github.com/IBM-Cloud/ibm-cloud-cli-release"
SRC_URI="amd64? ( https://download.clis.cloud.ibm.com/ibm-cloud-cli/${PV}/IBM_Cloud_CLI_${PV}_amd64.tar.gz )
	x86? ( https://download.clis.cloud.ibm.com/ibm-cloud-cli/${PV}/IBM_Cloud_CLI_${PV}_386.tar.gz )"

LICENSE="Apache-2.0 BSD IBM MIT"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
RESTRICT="bindist mirror"

QA_PREBUILT="usr/bin/ibmcloud"

S="${WORKDIR}/Bluemix_CLI"

src_prepare() {
	default

	# Remove non-existed references
	sed -i '/PROGS/s/"bluemix" "bx" //' autocomplete/bash_autocomplete
}

src_install() {
	newbashcomp autocomplete/bash_autocomplete ibmcloud
	insinto /usr/share/zsh/site-functions
	newins autocomplete/zsh_autocomplete _ibmcloud
	dobin bin/ibmcloud
	pax-mark -m "${ED}"/bin/ibmcloud
}

pkg_postinst() {
	einfo "To get started, open a terminal window and enter \"ibmcloud help\""
}
