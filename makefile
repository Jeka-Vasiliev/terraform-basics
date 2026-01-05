.PHONY: init plan apply

AWS_CREDS := AWS_ACCESS_KEY_ID=test AWS_SECRET_ACCESS_KEY=test

dev:
	$(AWS_CREDS) terraform workspace select dev

init:
	$(AWS_CREDS) terraform init

plan:
	$(AWS_CREDS) terraform plan

apply:
	$(AWS_CREDS) terraform apply