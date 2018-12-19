# google settings
PROJECTID = linear-freehold-196017
TERRAFORMUSER = terraform

# gandi settings
GANDIDOMAIN = bcow.me
GANDIID := $(shell cat creds/gandi.key)
DOMAINUUID := $(shell curl -s -H "X-Api-Key: $(GANDIID)" https://dns.api.gandi.net/api/v5/domains/$(GANDIDOMAIN) |python -c 'import json,sys;print json.load(sys.stdin)["zone_uuid"]')

serviceaccountprincipal:
	gcloud iam service-accounts create terraform --display-name "Terraform automation account"

serviceaccountiamrole:
	gcloud projects add-iam-policy-binding $(PROJECTID) --member serviceAccount:$(TERRAFORMUSER)@$(PROJECTID).iam.gserviceaccount.com --role roles/editor

serviceaccountkey:
	gcloud iam service-accounts keys create creds/serviceaccount.json --iam-account $(TERRAFORMUSER)@$(PROJECTID).iam.gserviceaccount.com

createserviceaccount: serviceaccountprincipal serviceaccountiamrole serviceaccountkey

terraforminit:
	terraform init

terraformplan: terraforminit
	terraform plan --out=bcowme.plan

terraformapply: terraformplan
	terraform apply bcowme.plan

terraformgandiimport: terraforminit
	terraform import gandi_zone.bcow_me $(DOMAINUUID)

# eof
