# azure-resources
Terraform configs for Azure resources

Steps to setup an infra
```
cd <folder> 
terraform init
./run.sh
terraform apply "tfplan" #an output of the above command
```

Note:
- Feel free to edit the variables file to your use case
- Remember to **delete resources** as soon as you are done making use of them.
```
terraform destroy
```