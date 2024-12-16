## Create the Redis Cluster
[Terraform Reference](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/redis_cache)
- Run the following commands, after confirming your values in the ```redis-config/variables.tf``` path.
```
terraform init
./run.sh
```

## How to Conned to the Cluster
- When ```cluster_public_network_access``` is set to ```true```, connect via CLI or any DBMS
<img width="1671" alt="image" src="https://github.com/user-attachments/assets/6074a897-99d3-4bb7-91a4-de02b3ae7f33" />

<img width="1637" alt="image" src="https://github.com/user-attachments/assets/edf0e23c-dde0-4833-8b43-b3ff136e9a14" />

- When ```cluster_public_network_access``` is set to ```false```, connect via CLI
<img width="1188" alt="image" src="https://github.com/user-attachments/assets/05b52cbc-ce42-450c-b69c-cd4c771c08cd" />

<img width="1352" alt="image" src="https://github.com/user-attachments/assets/0f4f65cc-7f57-4260-9cbd-0c71cdb80559" />

<img width="1352" alt="image" src="https://github.com/user-attachments/assets/97bf4d51-934f-4301-b164-e702cc4e85b3" />
