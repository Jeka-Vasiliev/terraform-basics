.PHONY: init plan-dev apply-dev dev

AWS_CREDS := AWS_ACCESS_KEY_ID=test AWS_SECRET_ACCESS_KEY=test

dev:
	$(AWS_CREDS) terraform workspace select dev

init:
	$(AWS_CREDS) terraform init

plan-dev:
	$(AWS_CREDS) terraform plan

apply-dev:
	$(AWS_CREDS) terraform apply -auto-approve