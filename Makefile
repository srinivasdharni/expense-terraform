dev:
		
		terraform init -backend-config=env-dev/state.tfvars
		terraform apply -auto-approve -var-file=env-dev/inputs.tfvars

prod:
		
		terraform init -backend-config=env-prod/state.tfvars
		terraform apply -auto-approve -var-file=env-prod/inputs.tfvars

dev-destroy:
		
		terraform init -backend-config=env-dev/state.tfvars
		terraform destroy -auto-approve -var-file=env-dev/inputs.tfvars

prod-destroy:
		
		terraform init -backend-config=env-prod/state.tfvars
		terraform destroy -auto-approve -var-file=env-prod/inputs.tfvars