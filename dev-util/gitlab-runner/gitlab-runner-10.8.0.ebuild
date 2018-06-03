# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# golang-vcs-snapshot doesn't support gitlab.org, golang.org, google.com uri scheme, keep sources as is
EGO_VENDOR=( "github.com/BurntSushi/toml a368813c5e648fee92e5f6c30e3944ff9d5e8895"
	"github.com/sirupsen/logrus 8c0189d9f6bbf301e5d055d34268156b317016af"
	"github.com/ayufan/golang-kardianos-service 0c8eb6d8fff2e2fb884a7bfd23e183fb63c0eff3"
	"github.com/nolith/docker-distribution 6664ec703991875e14419ff4960921cce7678bab"
	"github.com/nolith/moby 66e6beeb249948634e2815ef5cac97984d5c0d56"
	"github.com/docker/go-connections 3ede32e2033de7505e6500d6c868c2b9ed9f169d"
	"github.com/docker/machine 7b7a141da84480342357c51838be142bf183b095"
	"github.com/getsentry/raven-go dffeb57df75d6a911f00232155194e43d79d38d7"
	"github.com/golang/mock 06883d979f10cc178f2716846215c8cf90f9e363"
	"github.com/gorhill/cronexpr f0984319b44273e83de132089ae42b1810f4933b"
	"github.com/hashicorp/go-version 03c5bf6be031b6dd45afec16b1cf94fc8938bc77"
	"github.com/jpillora/backoff 06c7a16c845dc8e0bf575fafeeca0f5462f5eb4d"
	"github.com/kardianos/osext c2c54e542fb797ad986b31721e1baedf214ca413"
	"github.com/minio/minio-go 4e0f567303d4cc90ceb055a451959fb9fc391fb9"
	"github.com/prometheus/client_golang 334af0119a8f8fb6af5bb950d535c482cac7f836"
	"github.com/stretchr/testify b1f989447a57594c728884458a39abf3a73447f7"
	"github.com/tevino/abool 3c25f2fe7cd0ef3eabefce1d90efd69a65d35b12"
	"github.com/urfave/cli cfb38830724cc34fedffe9a2a29fb54fa9169cd1"
	"github.com/go-yaml/yaml e4d366fc3c7938e2958e662b4258c7a89e1f0e3e"
	"github.com/kubernetes/kubernetes b0deb2eb8f4037421077f77cb163dbb4c0a2a9f5"
	"github.com/Azure/go-ansiterm 19f72df4d05d31cbe1c56bfc8045c96babff6c7e"
	"github.com/Microsoft/go-winio ce2922f643c8fd76b46cadc7f404a06282678b34"
	"github.com/blang/semver 60ec3488bfea7cca02b021d106d9911120d25fe9"
	"github.com/coreos/go-oidc 1efe0e1303a62da553fcb6beb8bd2aa9250c0ca8"
	"github.com/docker/docker-credential-helpers b7c53e02cd1a9a01500a58f22d83c6e964bc59db"
	"github.com/docker/engine-api 4290f40c056686fcaa5c9caf02eac1dde9315adf"
	"github.com/docker/go-units eb879ae3e2b84e2a142af415b679ddeda47ec71c"
	"github.com/docker/spdystream 449fdfce4d962303d702fec724ef0ad181c92528"
	"github.com/emicklei/go-restful 89ef8af493ab468a45a42bb0d89a06fccdd2fb22"
	"github.com/ghodss/yaml aa0c862057666179de291b67d9f093d12b5a8473"
	"github.com/go-ini/ini 20b96f641a5ea98f2f8619ff4f3e061cff4833bd"
	"github.com/gogo/protobuf f20a1444730c7d9949b880a0309e737d007def25"
	"github.com/google/cadvisor 2ed7198f77395ee9a172878a0a7ab92ab59a2cfd"
	"github.com/google/gofuzz fd52762d25a41827db7ef64c43756fd4b9f7e382"
	"github.com/gorilla/context 08b5f424b9271eedf6f9f0ce86cb9396ed337a42"
	"github.com/gorilla/mux 599cba5e7b6137d46ddf58fb1765f5d928e69604"
	"github.com/imdario/mergo 50d4dbd4eb0e84778abe37cefef140271d96fade"
	"github.com/jonboulle/clockwork e3653ace2d63753697e0e5b07b9393971c0bba9d"
	"github.com/juju/ratelimit 77ed1c8a01217656d2080ad51981f6e99adaa177"
	"github.com/minio/go-homedir 4d76aabb80b22bad8695d3904e943f1fb5e6199f"
	"github.com/opencontainers/runtime-spec 313f40bdfcc04c6b0f7b8a8c3e91a7b7a3a0ef4e"
	"github.com/pborman/uuid c55201b036063326c5b1b89ccfe45a184973d073"
	"github.com/prometheus/procfs abf152e5f3e97f2fafac028d2cc06c1feb87ffa5"
	"github.com/spf13/pflag 4f9190456aed1c2113ca51ea9b89219747458dc1"
	"github.com/stretchr/objx cbeaeb16a013161a98496fad62933b1d21786672"
	"github.com/ugorji/go 4a1cb5252a6951f715a85d0e4be334c2a2dbf2a2"
	"github.com/vbatts/tar-split e4899282720706fae5fde9dc1ee80bc3fefe10c2" )

EGO_PN="gitlab.com/gitlab-org/gitlab-runner"

inherit eutils golang-build golang-vcs-snapshot readme.gentoo-r1 systemd tmpfiles user

DESCRIPTION="The official GitLab CI runner"
HOMEPAGE="https://gitlab.com/gitlab-org/gitlab-runner"
SRC_URI="https://${EGO_PN}/repository/v${PV}/archive.tar.bz2 -> ${P}.tar.bz2
	!docker-build? ( https://gitlab-runner-downloads.s3.amazonaws.com/v${PV}/docker/prebuilt-x86_64.tar.xz
		https://gitlab-runner-downloads.s3.amazonaws.com/v${PV}/docker/prebuilt-arm.tar.xz )
	${EGO_VENDOR_URI}"
# prebuilt tarrballs don't have a version, maybe we will have a problem here

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="docker-build"

# dev-go/gogo-protobuf doesn't provide sources
# dev-go/toml doesn't provide sources
# dev-go/go-oauth2 doesn't provide all sources
RDEPEND="dev-lang/go:=
	dev-go/go-crypto:=
	dev-go/go-net:=
	dev-go/go-protobuf:=
	dev-go/go-sys:=
	dev-go/zglob:="
DEPEND="${RDEPEND}
	dev-go/go-bindata:=
	docker-build? ( app-emulation/docker )"

S="${WORKDIR}/${P}/src/${EGO_PN}"

RESTRICT="mirror strip"

DOCS=( CHANGELOG.md README.md )

PATCHES=( # Don't build go tools
	"${FILESDIR}"/"${P}"-makefile.patch )

DOC_CONTENTS="Register the runner as root using\\n
\\t# gitlab-runner register\\n
Configure the runner in /etc/gitlab-runner/config.toml"

pkg_setup() {
	enewgroup gitlab
	enewuser runner -1 -1 /var/lib/"${PN}" gitlab
}

src_unpack() {
	golang-vcs-snapshot_src_unpack

	if ! use docker-build ; then
		mkdir -p "${S}"/out/docker
		ln -sf "${DISTDIR}"/prebuilt-x86_64.tar.xz "${S}"/out/docker/prebuilt-x86_64.tar.xz
		ln -sf "${DISTDIR}"/prebuilt-arm.tar.xz "${S}"/out/docker/prebuilt-arm.tar.xz
	fi
}

src_prepare() {
	default

	if ! use docker-build ; then
		sed -i "s/docker info/false/" Makefile \
			|| die "sed for docker info in Makefile failed"
	fi

	# Remove git references and downloads via curl
	sed -i -e "s#./ci/version#echo ${PV}#" \
		-e "s/git rev-parse --short=8 HEAD/echo ${PV}/" \
		-e "s#git show-ref.*\$#echo gentoo)#" \
		-e "s#git describe.*\$#echo 0), 0)#" \
		-e "/^LATEST_STABLE_TAG/d" \
		-e '/curl -o out\/docker/,+1 d' \
		Makefile || die "sed for Makefile failed"

	# Remove bundled libs to use provided by portage
	rm -rf vendor/github.com/davecgh || die "failed to remove go-spew"
	rm -rf vendor/golang.org/x/{crypto,net,sys} || die "failed to remove golang.org"
	rm -rf vendor/github.com/jteeuwen/go-bindata || die "failed to remove go-bindata"
	rm -rf vendor/github.com/mattn/go-zglob || die "failed to remove go-zglob"
	rm -rf vendor/github.com/golang/protobuf || die "failed to remove go-protobuf"
}

src_compile() {
	emake GOPATH="${S}/.gopath:$(get_golibdir_gopath)" build_current
}

src_install() {
	einstalldocs

	dobin out/binaries/"${PN}"

	insinto /etc/"${PN}"
	doins config.toml.example
	fowners -R runner:gitlab /etc/"${PN}"

	newconfd "${FILESDIR}"/"${PN}".confd "${PN}"
	newinitd "${FILESDIR}"/"${PN}".initd "${PN}"
	systemd_dounit "${FILESDIR}"/"${PN}".service
	newtmpfiles "${FILESDIR}"/"${PN}".tmpfile "${PN}".conf

	readme.gentoo_create_doc
}

pkg_postinst() {
	tmpfiles_process "${PN}".conf
	readme.gentoo_print_elog
}
