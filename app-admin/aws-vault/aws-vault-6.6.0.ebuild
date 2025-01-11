# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1 go-module

DESCRIPTION="A vault for securely storing and accessing AWS credentials"
HOMEPAGE="https://github.com/99designs/aws-vault"
SRC_URI="https://github.com/99designs/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz
	https://github.com/SpiderX/portage-overlay/raw/deps/${P}-deps.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DOCS=( {README,USAGE}.md )

src_compile() {
	ego build -ldflags="-X main.Version=${PV} -s -w" -trimpath \
		-o ./bin/"${PN}"
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin bin/aws-vault

	newinitd "${FILESDIR}"/aws-vault.initd aws-vault
	newconfd "${FILESDIR}"/aws-vault.confd aws-vault

	newbashcomp contrib/completions/bash/aws-vault.bash aws-vault
	insinto /usr/share/fish/completion
	newins contrib/completions/fish/aws-vault.fish aws-vault
	insinto /usr/share/zsh/site-functions
	newins contrib/completions/zsh/aws-vault.zsh _aws-vault
	dodoc contrib/scripts/aws-iam-{create,resync}-yubikey-mfa.sh
}

pkg_postinst() {
	if ! has_version app-admin/pass && ! has_version kde-apps/kwalletmanager \
		&& ! has_version gnome-base/gnome-keyring ; then
		einfo "You should consider to install app-admin/pass, gnome-base/gnome-keyring"
		einfo "or kde-apps/kwalletmanager to be able to use them as backends"
	fi
}
