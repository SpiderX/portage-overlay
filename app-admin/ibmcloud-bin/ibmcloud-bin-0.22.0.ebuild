# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit bash-completion-r1 pax-utils

DESCRIPTION="IBM Cloud Developer Tools"
HOMEPAGE="https://github.com/IBM-Cloud/ibm-cloud-cli-release"
SRC_URI="amd64? ( https://public.dhe.ibm.com/cloud/bluemix/cli/bluemix-cli/${PV}/IBM_Cloud_CLI_${PV}_amd64.tar.gz )
	x86? ( https://public.dhe.ibm.com/cloud/bluemix/cli/bluemix-cli/${PV}/IBM_Cloud_CLI_${PV}_386.tar.gz )"

LICENSE="Apache-2.0 BSD IBM MIT"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="bash-completion zsh-completion"
RESTRICT="bindist mirror"

RDEPEND="bash-completion? ( app-shells/bash-completion )
	zsh-completion? ( app-shells/zsh-completions )"

QA_PREBUILT="usr/bin/cf usr/bin/ibmcloud usr/bin/ibmcloud-analytics"

S="${WORKDIR}/Bluemix_CLI"

src_prepare() {
	default

	# Remove non-existed references
	sed -i '/PROGS/s/"bluemix" "bx" //' autocomplete/bash_autocomplete
}

src_install() {
	use bash-completion && newbashcomp autocomplete/bash_autocomplete ibmcloud
	if use zsh-completion ; then
		insinto /usr/share/zsh/site-functions
		newins autocomplete/zsh_autocomplete _ibmcloud
	fi

	dobin bin/ibmcloud{,-analytics} bin/cfcli/cf

	pax-mark -m "${ED}"/bin/ibmcloud{,-analytics}
}

pkg_postinst() {
	einfo "To get started, open a terminal window and enter \"ibmcloud help\""
}
