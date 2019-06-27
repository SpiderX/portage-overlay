# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/Jimdo/${PN}"
EGIT_REPO_URI="https://${EGO_PN}.git"
EGIT_CHECKOUT_DIR="${WORKDIR}/${P}/src/${EGO_PN}"

inherit git-r3 golang-build

DESCRIPTION="Utility to import/export data from HashiCorp Vault"
HOMEPAGE="https://github.com/Jimdo/yaml-vault"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""

DOCS=( src/"${EGO_PN}"/{README,History}.md )

src_install() {
	einstalldocs
	dobin yaml-vault
}
