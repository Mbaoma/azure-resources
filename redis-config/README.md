## Create the Redis Cluster
[Terraform Reference](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_cache)
- Run the following commands, after confirming your values in the ```redis-config/variables.tf``` path.
```
terraform init
./run.sh
```

## How to Conned to the Cluster
- Use the connection string, as shown below (publicly accessible cluster)
<img width="1671" alt="image" src="https://github.com/user-attachments/assets/6074a897-99d3-4bb7-91a4-de02b3ae7f33" />

<img width="1637" alt="image" src="https://github.com/user-attachments/assets/edf0e23c-dde0-4833-8b43-b3ff136e9a14" />
