default-apply:
	terraform workspace select default && \
	terraform apply -var-file "DEFAULT.tfvars.json" -auto-approve

default-destroy:
	terraform workspace select default && \
	terraform destroy -var-file "DEFAULT.tfvars.json" -auto-approve

PRO-apply:
	terraform workspace select PRO && \
	terraform apply -var-file "PRO.tfvars.json"

PRO-destroy:
	terraform workspace select PRO && \
	terraform destroy -var-file "PRO.tfvars.json"