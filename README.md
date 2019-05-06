# iac-sample

This example shows how to securely (with transcrypt) and extensibly (with Jsonnet)
manage your infrastructure as code (with Terraform).

## Getting Started

* Install [Terraform](https://learn.hashicorp.com/terraform/getting-started/install.html)
* Install [IBM Cloud Terraform Provider](https://github.com/IBM-Cloud/terraform-provider-ibm)
* Install [transcrypt](https://github.com/elasticdog/transcrypt)
* Install [Jsonnet](https://jsonnet.org/learning/getting_started.html) (either the C++ or Go binary, and for MacOS you can use `brew install jsonnet`)
* Register for [IBM Cloud](https://cloud.ibm.com/registration) and obtain an [API key](https://cloud.ibm.com/iam#/apikeys)
* Fork this repository and open a terminal at the root of the repo
* Initialize transcrypt `transcrypt -c aes-256-cbc -p 'changeme'`
* Rekey transcrypt to change encryption password `transcrypt -r -c aes-256-cbc -p 'yournewpass'`
* In environments/secrets.json, change 'bluemix_api_key' to your IBM Cloud API Key
* In environments/config.jsonnet
  * Set 'org' to something unique in IBM Cloud
  * Set 'route' to something unique in IBM Cloud
  * Set 'developer' and 'manager' to your email address

## Executing Terraform

Executing Terraform is a two step process:
1) Convert Jsonnet configuration file to Terraform JSON file
2) Execute Terraform using the Terraform JSON file

This can be performed in a single command line execution:
```
cd environments/dev
jsonnet main.tf.jsonnet > main.tf.json && terraform plan -out plan.out
```

Review the plan, and if satisfied:
```
terraform apply plan.out
```

Once Terraform completes, you should be able to visit your new site at: https://<your unique route>.mybluemix.net/ .
You should see a heading that says 'Welcome.'

That's it.