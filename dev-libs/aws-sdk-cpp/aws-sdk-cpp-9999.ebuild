# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

inherit cmake git-r3 python-single-r1

CLIENTS="accessanalyzer account acm acm-pca aiops amp amplify amplifybackend amplifyuibuilder apigateway
apigatewaymanagementapi apigatewayv2 appconfig appconfigdata appfabric appflow appintegrations application-autoscaling
applicationcostprofiler application-insights application-signals appmesh apprunner appstream appsync apptest
arc-zonal-shift artifact athena auditmanager autoscaling autoscaling-plans AWSMigrationHub awstransfer b2bi backup
backup-gateway backupsearch batch bcm-data-exports bcm-pricing-calculator bedrock bedrock-agent bedrock-agent-runtime
bedrock-data-automation bedrock-data-automation-runtime bedrock-runtime billing billingconductor braket budgets ce
chatbot chime chime-sdk-identity chime-sdk-media-pipelines chime-sdk-meetings chime-sdk-messaging chime-sdk-voice
cleanrooms cleanroomsml cloud9 cloudcontrol clouddirectory cloudformation cloudfront cloudfront-keyvaluestore cloudhsm
cloudhsmv2 cloudsearch cloudsearchdomain cloudtrail cloudtrail-data codeartifact codebuild codecatalyst codecommit
codeconnections codedeploy codeguruprofiler codeguru-reviewer codeguru-security codepipeline codestar-connections
codestar-notifications cognito-identity cognito-idp cognito-sync comprehend comprehendmedical compute-optimizer config
connect connectcampaigns connectcampaignsv2 connectcases connect-contact-lens connectparticipant controlcatalog
controltower cost-optimization-hub cur customer-profiles databrew dataexchange datapipeline datasync datazone dax
deadline detective devicefarm devops-guru directconnect directory-service-data discovery dlm dms docdb docdb-elastic
drs ds dsql dynamodb dynamodbstreams ebs ec2 ec2-instance-connect ecr ecr-public ecs eks eks-auth elasticache
elasticbeanstalk elasticfilesystem elasticloadbalancing elasticloadbalancingv2 elasticmapreduce elastictranscoder email
emr-containers emr-serverless entityresolution es eventbridge events evidently evs finspace finspace-data firehose fis
fms forecast forecastquery frauddetector freetier fsx gamelift gameliftstreams geo-maps geo-places geo-routes glacier
globalaccelerator glue grafana greengrass greengrassv2 groundstation guardduty health healthlake iam identitystore
imagebuilder importexport inspector inspector2 inspector-scan internetmonitor invoicing iot iot1click-devices
iot1click-projects iotanalytics iot-data iotdeviceadvisor iotevents iotevents-data iotfleethub iotfleetwise
iot-jobs-data iot-managed-integrations iotsecuretunneling iotsitewise iotthingsgraph iottwinmaker iotwireless ivs
ivschat ivs-realtime kafka kafkaconnect kendra kendra-ranking keyspaces keyspacesstreams kinesis kinesisanalytics
kinesisanalyticsv2 kinesisvideo kinesis-video-archived-media kinesis-video-media kinesis-video-signaling
kinesis-video-webrtc-storage kms lakeformation lambda launch-wizard lex lex-models lexv2-models lexv2-runtime
license-manager license-manager-linux-subscriptions license-manager-user-subscriptions lightsail location logs
lookoutequipment lookoutmetrics lookoutvision m2 machinelearning macie2 mailmanager managedblockchain
managedblockchain-query marketplace-agreement marketplace-catalog marketplacecommerceanalytics marketplace-deployment
marketplace-entitlement marketplace-reporting mediaconnect mediaconvert medialive mediapackage mediapackagev2
mediapackage-vod mediastore mediastore-data mediatailor medical-imaging memorydb meteringmarketplace mgn
migrationhub-config migrationhuborchestrator migration-hub-refactor-spaces migrationhubstrategy monitoring mpa mq
mturk-requester mwaa neptune neptunedata neptune-graph network-firewall networkflowmonitor networkmanager
networkmonitor notifications notificationscontacts oam observabilityadmin odb omics opensearch opensearchserverless
opsworks opsworkscm organizations osis outposts panorama partnercentral-selling payment-cryptography
payment-cryptography-data pca-connector-ad pca-connector-scep pcs personalize personalize-events personalize-runtime pi
pinpoint pinpoint-email pinpoint-sms-voice-v2 pipes polly pricing proton qapps qbusiness qconnect qldb qldb-session
quicksight ram rbin rds rds-data redshift redshift-data redshift-serverless rekognition repostspace resiliencehub
resource-explorer-2 resource-groups resourcegroupstaggingapi robomaker rolesanywhere route53 route53domains
route53profiles route53-recovery-cluster route53-recovery-control-config route53-recovery-readiness route53resolver rum
s3 s3control s3-crt s3outposts s3tables sagemaker sagemaker-a2i-runtime sagemaker-edge sagemaker-featurestore-runtime
sagemaker-geospatial sagemaker-metrics sagemaker-runtime savingsplans scheduler schemas sdb secretsmanager securityhub
security-ir securitylake serverlessrepo servicecatalog servicecatalog-appregistry servicediscovery service-quotas sesv2
shield signer simspaceweaver sms sms-voice snowball snow-device-management sns socialmessaging sqs ssm ssm-contacts
ssm-guiconnect ssm-incidents ssm-quicksetup ssm-sap sso sso-admin sso-oidc states storagegateway sts supplychain
support support-app swf synthetics taxsettings textract timestream-influxdb timestream-query timestream-write tnb
transcribe transcribestreaming translate trustedadvisor verifiedpermissions voice-id vpc-lattice waf waf-regional wafv2
wellarchitected wisdom workdocs worklink workmail workmailmessageflow workspaces workspaces-instances
workspaces-thin-client workspaces-web xray"

DESCRIPTION="AWS SDK for C++"
HOMEPAGE="https://github.com/aws/aws-sdk-cpp"
EGIT_REPO_URI="https://github.com/aws/${PN}.git"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="+curl speech +ssl test ${CLIENTS}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-libs/aws-crt-cpp:=
	sys-libs/zlib:=
	curl? ( net-misc/curl:= )
	speech? ( media-libs/libpulse )
	ssl? ( dev-libs/openssl:= )
	${PYTHON_DEPS}"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

DOCS=( {CHANGELOG,README}.md )

src_configure() {
	local client target
	for client in ${CLIENTS} ; do use "$client" && target+=";$client" ; done

	local mycmakeargs=(
		-DAUTORUN_UNIT_TESTS="$(usex test)"
		-DAWS_SDK_WARNINGS_ARE_ERRORS=OFF
		-DBUILD_DEPS=OFF
		-DBUILD_ONLY="${target}"
		-DENABLE_TESTING="$(usex test)"
		-DNO_ENCRYPTION="$(usex !ssl)"
		-DNO_HTTP_CLIENT="$(usex !curl)"
	)
	cmake_src_configure
}
