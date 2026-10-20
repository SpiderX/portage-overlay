# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )

inherit optfeature python-single-r1 readme.gentoo-r1 shell-completion

DESCRIPTION="Google Cloud CLI"
HOMEPAGE="https://docs.cloud.google.com/sdk/gcloud"
SRC_URI="amd64? ( https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/${P}-linux-x86_64.tar.gz )
	arm64? ( https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/${P}-linux-arm.tar.gz )"
S="${WORKDIR}/google-cloud-sdk"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	$(python_gen_cond_dep '
	dev-python/absl-py[${PYTHON_USEDEP}]
	dev-python/antlr3-python-runtime[${PYTHON_USEDEP}]
	dev-python/argcomplete[${PYTHON_USEDEP}]
	dev-python/attrs[${PYTHON_USEDEP}]
	dev-python/boto3[${PYTHON_USEDEP}]
	dev-python/cachetools[${PYTHON_USEDEP}]
	dev-python/charset-normalizer[${PYTHON_USEDEP}]
	dev-python/certifi[${PYTHON_USEDEP}]
	dev-python/containerregistry[${PYTHON_USEDEP}]
	dev-python/crcmod[${PYTHON_USEDEP}]
	dev-python/dnspython[${PYTHON_USEDEP}]
	dev-python/fasteners[${PYTHON_USEDEP}]
	dev-python/frozendict[${PYTHON_USEDEP}]
	dev-python/httplib2[${PYTHON_USEDEP}]
	dev-python/inflection[${PYTHON_USEDEP}]
	dev-python/google-api-core[${PYTHON_USEDEP}]
	dev-python/google-api-python-client[${PYTHON_USEDEP}]
	dev-python/google-apitools[${PYTHON_USEDEP}]
	dev-python/google-auth[${PYTHON_USEDEP}]
	dev-python/google-auth-httplib2[${PYTHON_USEDEP}]
	dev-python/google-auth-oauthlib[${PYTHON_USEDEP}]
	dev-python/google-cloud-appengine-admin[${PYTHON_USEDEP}]
	dev-python/google-cloud-appengine-logging[${PYTHON_USEDEP}]
	dev-python/google-cloud-audit-log[${PYTHON_USEDEP}]
	dev-python/google-cloud-bigquery-logging[${PYTHON_USEDEP}]
	dev-python/google-cloud-bigtable[${PYTHON_USEDEP}]
	dev-python/google-cloud-iam[${PYTHON_USEDEP}]
	dev-python/google-cloud-pubsublite[${PYTHON_USEDEP}]
	dev-python/google-reauth[${PYTHON_USEDEP}]
	dev-python/googleapis-common-protos[${PYTHON_USEDEP}]
	dev-python/grpc-google-iam-v1[${PYTHON_USEDEP}]
	dev-python/grpcio[${PYTHON_USEDEP}]
	dev-python/idna[${PYTHON_USEDEP}]
	dev-python/jmespath[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]
	dev-python/kubernetes[${PYTHON_USEDEP}]
	dev-python/lark[${PYTHON_USEDEP}]
	dev-python/mako[${PYTHON_USEDEP}]
	dev-python/oauth2client[${PYTHON_USEDEP}]
	dev-python/oauthlib[${PYTHON_USEDEP}]
	dev-python/overrides[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/ply[${PYTHON_USEDEP}]
	dev-python/portpicker[${PYTHON_USEDEP}]
	dev-python/proto-plus[${PYTHON_USEDEP}]
	dev-python/protobuf[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	dev-python/pyasn1[${PYTHON_USEDEP}]
	dev-python/pyasn1-modules[${PYTHON_USEDEP}]
	dev-python/pyparsing[${PYTHON_USEDEP}]
	dev-python/pysocks[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/python-dotenv[${PYTHON_USEDEP}]
	dev-python/python-hcl2[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/pyu2f[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/requests-oauthlib[${PYTHON_USEDEP}]
	dev-python/rsa[${PYTHON_USEDEP}]
	dev-python/ruamel-yaml[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/sqlparse[${PYTHON_USEDEP}]
	dev-python/termcolor[${PYTHON_USEDEP}]
	dev-python/typing-extensions[${PYTHON_USEDEP}]
	dev-python/uritemplate[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
	dev-python/wcwidth[${PYTHON_USEDEP}]
	dev-python/websocket-client[${PYTHON_USEDEP}]
	')"

PATCHES=( "${FILESDIR}/${PN}"-589.0.0-ruamel-yaml-compat.patch
	"${FILESDIR}/${PN}"-589.0.0-system-antlr3.patch
	"${FILESDIR}/${PN}"-589.0.0-system-crcmod.patch
	"${FILESDIR}/${PN}"-589.0.0-system-google-cloud-protos.patch
	"${FILESDIR}/${PN}"-589.0.0-system-hcl2.patch
	"${FILESDIR}/${PN}"-589.0.0-system-ipaddress.patch
	"${FILESDIR}/${PN}"-589.0.0-system-oauth2client.patch
	"${FILESDIR}/${PN}"-589.0.0-unbundle-ml-sdk.patch )

DOCS=( RELEASE_NOTES )
DOC_CONTENTS="The following features are unavailable:\\n
* Interactive gcloud shell (requires obsolete prompt_toolkit 1.x).\\n
* Legacy Cloud ML Engine local prediction (bundled ML SDK removed).\\n\\n"

QA_PREBUILT="usr/share/google-cloud-sdk/bin/gcloud-crc32c"

src_prepare() {
	default

	# remove unused installers and bundled Python and gsutil
	rm -r deb rpm install.{bat,sh} \
		platform/{bundledpythonunix,gsutil,gcloud-crc32c_licenses} \
		bin/{gsutil,bootstrapping/gsutil.py} || die

	# remove bundled BigQuery dependencies, retaining the SDK-specific pyglib
	find platform/bq/third_party -mindepth 1 -maxdepth 1 \
		! -name pyglib -exec rm -r -- {} + || die

	# remove bundled dependencies, keeping SDK-specific modules
	find "${S}/lib/third_party" -mindepth 1 -maxdepth 1 \
		! -name gae_ext_runtime ! -name orchestration_pipelines_models \
		-exec rm -rf -- {} + || die

	# remove legacy interactive CLI requiring prompt_toolkit 1.x
	rm -r lib/googlecloudsdk/command_lib/interactive || die
	rm lib/surface/interactive.py lib/googlecloudsdk/core/document_renderers/token_renderer.py || die

	# remove bundled Python 2 components
	find . -type d -name python2 -prune -exec rm -r {} + || die

	# enable system Python site-packages for unbundled dependencies
	sed -i '/^setup_cloudsdk_python$/a export CLOUDSDK_PYTHON_SITEPACKAGES=1' \
		bin/{gcloud,bq,docker-credential-gcloud,git-credential-gcloud.sh,java_dev_appserver.sh} || die

	# use system dev-python/protobuf instead of bundled protobuf
	grep -rlZ --include='*.py' 'cloudsdk\.google\.protobuf' lib |
		xargs -0 -r sed -i 's/cloudsdk\.google\.protobuf/google.protobuf/g' || die

	# disable SDK component management
	sed -i '/disable_updater/s|false|true|' lib/googlecloudsdk/core/config.json || die

	python_fix_shebang lib/googlecloudsdk/gcloud_main.py lib/gcloud.py \
		bin/bootstrapping/bq.py bin/dev_appserver.py \
		platform/ext-runtime/*/bin/{detect,generate_configs}

	# remove generated Python bytecode
	find . -type d -name __pycache__ -prune -exec rm -r -- {} + || die
}

src_install() {
	einstalldocs

	dodir /usr/share/google-cloud-sdk
	cp -a "${S}"/. "${ED}"/usr/share/google-cloud-sdk || die

	dosym ../share/google-cloud-sdk/bin/gcloud /usr/bin/gcloud
	dosym ../share/google-cloud-sdk/bin/gcloud-crc32c /usr/bin/gcloud-crc32c
	dosym ../share/google-cloud-sdk/bin/bq /usr/bin/bq
	dosym ../share/google-cloud-sdk/bin/docker-credential-gcloud /usr/bin/docker-credential-gcloud
	dosym ../share/google-cloud-sdk/bin/git-credential-gcloud.sh /usr/bin/git-credential-gcloud.sh

	newbashcomp completion.bash.inc gcloud
	newzshcomp completion.zsh.inc _gcloud
	bashcomp_alias gcloud bq

	python_optimize "${ED}"/usr/share/google-cloud-sdk/lib/googlecloudsdk \
		"${ED}"/usr/share/google-cloud-sdk/lib/surface \
		"${ED}"/usr/share/google-cloud-sdk/platform/bq

	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog

	optfeature "legacy Google Cloud Storage CLI" net-misc/gsutil
}
