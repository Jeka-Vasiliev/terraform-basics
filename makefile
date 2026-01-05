.PHONY: init plan apply

AWS_CREDS := AWS_ACCESS_KEY_ID=test AWS_SECRET_ACCESS_KEY=test

dev:
	$(AWS_CREDS) terraform workspace select dev

init:
	$(AWS_CREDS) terraform init

plan-dev:
	$(AWS_CREDS) terraform plan -var-file=dev.tfvars

apply-dev:
	$(AWS_CREDS) terraform apply -var-file=dev.tfvars -auto-approve