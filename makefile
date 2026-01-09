.PHONY: ws-dev ws-default init plan apply build-provider start-mycloud-api

AWS_CREDS := AWS_ACCESS_KEY_ID=test AWS_SECRET_ACCESS_KEY=test

ws-dev:
	$(AWS_CREDS) terraform workspace select dev

ws-default:
	$(AWS_CREDS) terraform workspace select default

init:
	$(AWS_CREDS) terraform init

plan:
	$(AWS_CREDS) terraform plan

apply:
	$(AWS_CREDS) terraform apply -auto-approve

build-provider:
	cd terraform-provider-mycloud && go mod tidy && go build -o bin/terraform-provider-mycloud

start-mycloud-api:
	cd my-api && npm ci && npm start
