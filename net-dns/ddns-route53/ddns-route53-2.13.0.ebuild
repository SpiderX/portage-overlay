# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd

DESCRIPTION="Dynamic DNS for Amazon Route 53 on a time-based schedule"
HOMEPAGE="https://github.com/crazy-max/ddns-route53"
SRC_URI="https://github.com/crazy-max/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="acct-group/ddnsr53
	acct-user/ddnsr53"

DOCS=( {CHANGELOG,README}.md )

src_compile() {
	LDFLAGS="-X main.version=${PV}"

	GOFLAGS="-v -x -mod=vendor" \
		ego build -ldflags "${LDFLAGS}" -o ddns-route53 ./cmd/...
}

src_test() {
	GOFLAGS="-v -x -mod=vendor" \
		ego test -work ./...
}

src_install() {
	dobin ddns-route53
	newinitd "${FILESDIR}"/ddns-route53.initd ddns-route53
	newconfd "${FILESDIR}"/ddns-route53.confd ddns-route53
	systemd_dounit "${FILESDIR}"/ddns-route53.service

	# Generate sample config
	insopts -o ddnsr53 -g ddnsr53 -m 0644
	insinto /etc/ddns-route53
	newins - ddns-route53.yml < <(grep -m1 -A16 '```yaml' docs/config/index.md | tail -n +2 \
		|| die "grep failed for ddns-route53.yml" )
}
