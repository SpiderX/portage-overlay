# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module shell-completion

COMMIT="ead267c"

DESCRIPTION="Deployment and configuration of resources on remote machines"
HOMEPAGE="https://github.com/umputun/spot"
SRC_URI="https://github.com/umputun/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # lots of integration tests needs docker

src_compile() {
	DATE="$(date -u '+%Y%m%dT%H%M%S')"
	LDFLAGS="-w -X \"main.revision=${PV} (master-${COMMIT}-${DATE})\""

	GOFLAGS="-v -x -mod=vendor" \
		ego build -ldflags "${LDFLAGS}" -o spot ./cmd/spot
	GOFLAGS="-v -x -mod=vendor" \
		ego build -ldflags "${LDFLAGS}" -o spot-secrets ./cmd/secrets
}

src_test() {
	GOFLAGS="-v -x -mod=vendor" ego test -work ./...
}

src_install() {
	einstalldocs
	dobin spot spot-secrets
	doman spot.1
	insinto /usr/share/spot
	doins spot-example.yml
	insinto /usr/share/spot/schemas
	doins schemas/{inventory,playbook}.json

	newbashcomp completions/spot.bash spot
	newfishcomp completions/spot.fish spot
	newzshcomp completions/spot.zsh _spot
	newbashcomp completions/spot-secrets.bash spot-secrets
	newfishcomp completions/spot-secrets.fish spot-secrets
	newzshcomp completions/spot-secrets.zsh _spot-secrets
}
