# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module optfeature shell-completion

DESCRIPTION="A vault for securely storing and accessing AWS credentials"
HOMEPAGE="https://github.com/ByteNess/aws-vault"
SRC_URI="https://github.com/ByteNess/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND=">=dev-lang/go-1.26"

DOCS=( {README,USAGE}.md )

src_compile() {
	ego build -ldflags="-X main.Version=${PV}" -o aws-vault
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin aws-vault

	newinitd "${FILESDIR}"/aws-vault.initd aws-vault
	newconfd "${FILESDIR}"/aws-vault.confd aws-vault

	newbashcomp contrib/completions/bash/aws-vault.bash aws-vault
	newfishcomp contrib/completions/fish/aws-vault.fish aws-vault
	newzshcomp contrib/completions/zsh/aws-vault.zsh _aws-vault
	dodoc contrib/scripts/aws-iam-{create,resync}-yubikey-mfa.sh
}

pkg_postinst() {
	optfeature "storing passwords via Secret Service API provider" virtual/secret-service
	optfeature "storing passwords via passwordstore" app-admin/pass
}
