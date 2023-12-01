# Terraform final project

## Students
LECOLAZET Aymeric
PREKA Bruno

## `tf` alias
Make sure to have set `tf` alias. If not, simply run `terraform` instead. 

## Clone the `example-voting-app` codebase
```sh
git clone https://github.com/dockersamples/example-voting-app.git 
```

## Run Docker part
_Note: `seed` does not work_
```sh
cd docker
tf init
tf plan
tf apply
```
Browse to the output endpoints. 

## Run Terraform part
1. Generate a JSON key from a GCP service account then save it in `k8s` folder as `gcp-json-key.json` (see `terraform.tfvars.template`) 
2. Save `terraform.tfvars.template` as `terraform.tfvars` and set the `project_id` variable according to your GCP project ID
3. Run:
```sh
cd k8s
tf init
tf plan
tf apply
```
_Note: the first `tf apply` call will quite likely give a "no-ip" output since we need to allow some time to GCP to assign the IPs to the ingresses. Another try will make it. Else, check the GCP console (Kubernetes Engine > Services and ingresses > INGRESS)._ 
4. Browse to the output endpoints. _Allow some time to GCP to make the services fully available, otherwise you will face a 502 error._
