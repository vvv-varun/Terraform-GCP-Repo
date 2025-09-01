<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 7.0.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 7.0.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_firewall"></a> [firewall](#module\_firewall) | ./modules/firewall | n/a |
| <a name="module_inst_template"></a> [inst\_template](#module\_inst\_template) | ./modules/instance_template | n/a |
| <a name="module_lb"></a> [lb](#module\_lb) | ./modules/load_balancer | n/a |
| <a name="module_mig"></a> [mig](#module\_mig) | ./modules/mig | n/a |
| <a name="module_network"></a> [network](#module\_network) | ./modules/network | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./modules/vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [google_compute_health_check.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_health_check) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | `"prod"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | My GCP Project | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | List of regions, where region[0] will be the primary region | `list(string)` | <pre>[<br/>  "us-central1",<br/>  "europe-north1"<br/>]</pre> | no |
| <a name="input_web_bucket"></a> [web\_bucket](#input\_web\_bucket) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->