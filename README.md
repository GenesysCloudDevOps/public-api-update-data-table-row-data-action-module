A Terraform/CX as Code remote module for the following Genesys Cloud public API operation: Update Data Table Row

## Usage

Shown below is an example of how to configure the remote module.

```hcl
module "data_action" {
    source             = "git::https://github.com/GenesysCloudDevOps/public-api-update-data-table-row-data-action-module.git?ref=v2.0.0"
    action_name        = "Update Data Table Row"
    action_category    = "${module.gc_integration.integration_name}"
    integration_id     = "${module.gc_integration.integration_id}"
    secure_data_action = false

    data_table_custom_fields = [
        {
            field = "address"
            type  = "string"
        }, 
        {
            field = "age"
            type  = "integer"
        }
    ]
}
```

`Note:` The remote module for creating a Genesys Cloud data actions integration can be found [here](https://github.com/GenesysCloudDevOps/public-api-data-actions-integration-module "Opens github.com/GenesysCloudDevOps/public-api-data-actions-integration-module")

## Requirements

| Name | Version |
|------|---------|
| <a name="provider_terraform"></a>[terraform](https://www.terraform.io/) | >= 1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_genesyscloud"></a> [genesyscloud](https://registry.terraform.io/providers/MyPureCloud/genesyscloud/latest) | >= 1.0|


## Inputs

| Name | Description | Type | Required |
|------|-------------|------|:--------:|
| <a name="action_name"></a> [action_name](#action\_\name)  | The name for the Genesys Cloud data action. | `string` | yes |
| <a name="action_category"></a> [action_category](#action\_\category)  | Category of action. | `string` | yes |
| <a name="integration_id"></a> [integration_id](#integration\_\id)  | The ID of the integration this action is associated with. | `string` | yes |
| <a name="data_table_custom_fields"></a> [data_table_custom_fields](#data\_\table\_\custom\_\fields)  | A set of objects that define the custom fields of the data table. Example: [{'field': 'dob', 'type': 'string'}] | `set(object)` | yes |
| <a name="secure_data_action"></a> [secure_data_action](#integration\_\id)  | Indication of whether or not the action is designed to accept sensitive data. Defaults to `false`. | `bool` | no |