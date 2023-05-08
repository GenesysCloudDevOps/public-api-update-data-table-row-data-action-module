locals {
    contract_input_custom_fields = "%{ for obj in var.data_table_custom_fields } \"${obj.field}\": { \"type\": \"${obj.type}\" }, %{ endfor }"
}

resource "genesyscloud_integration_action" "action" {
    name           = var.action_name
    category       = var.action_category
    integration_id = var.integration_id
    secure         = var.secure_data_action
    
    contract_input  = format("{\"$schema\":\"http://json-schema.org/draft-04/schema#\",\"additionalProperties\":true,\"description\":\"using this to update the table\",\"properties\":{ %s \"DatatableId\":{\"description\":\"Data Table ID\",\"type\":\"string\"},\"Key\":{\"description\":\"Which key to update\",\"type\":\"string\"}},\"required\":[\"Key\",\"DatatableId\"],\"title\":\"Update Table\",\"type\":\"object\"}", local.contract_input_custom_fields)
    contract_output = jsonencode({
        "additionalProperties" = true,
        "properties" = {},
        "type" = "object"
    })
    
    config_request {
    request_template     = "{\n    \"key\":\"$${input.Key}\"\n %{ for obj in var.data_table_custom_fields } ,\"${obj.field}\": %{ if obj.type == "string" }\"%{ endif }$!{input.${obj.field}}%{ if obj.type == "string" }\"%{ endif }\n %{ endfor } \n}"
    request_type         = "PUT"
    request_url_template = "/api/v2/flows/datatables/$${input.DatatableId}/rows/$${input.Key.replace(' ','%20')}"
        headers = {
            UserAgent = "PureCloudIntegrations/1.0"
            Content-Type = "application/json"
        }
    }

    config_response {
        success_template = "$${rawResult}"
    }
}