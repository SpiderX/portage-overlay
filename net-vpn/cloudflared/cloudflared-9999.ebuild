# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 go-module systemd

DESCRIPTION="Argo Tunnel client"
HOMEPAGE="https://github.com/cloudflare/cloudflared"
EGIT_REPO_URI="https://github.com/cloudflare/${PN}.git"

LICENSE="Cloudflare"
SLOT="0"
RESTRICT="test"

RDEPEND="acct-group/cloudflared
	acct-user/cloudflared"

DOCS=( {CHANGES,README}.md RELEASE_NOTES )

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	default

	DATE="$(date -u '+%Y-%m-%d-%H%M UTC')"
	sed -i  -e "s/\${VERSION}/${PV}/" \
		-e "s/\${DATE}/${DATE}/" cloudflared_man_template \
			|| die "sed failed for cloudflared_man_template"
}

src_compile() {
	DATE="$(date -u '+%Y-%m-%d-%H%M UTC')"
	LDFLAGS="-X main.Version=${PV} -X \"main.BuildTime=${DATE}\""
	ego build -v -mod=vendor -ldflags="${LDFLAGS}" ./cmd/cloudflared
}

src_test() {
	ego test -v -mod=vendor -work ./...
}

src_install() {
	einstalldocs
	newman cloudflared_man_template cloudflared.1
	dobin cloudflared
	insinto /etc/cloudflared
	doins "${FILESDIR}"/config.yml
	newinitd "${FILESDIR}"/cloudflared.initd cloudflared
	newconfd "${FILESDIR}"/cloudflared.confd cloudflared
	systemd_dounit "${FILESDIR}"/cloudflared.service
}
