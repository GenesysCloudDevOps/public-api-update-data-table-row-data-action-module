resource "genesyscloud_integration_action" "action" {
    name           = var.action_name
    category       = var.action_category
    integration_id = var.integration_id
    secure         = var.secure_data_action
    
    contract_input  = jsonencode({
        "$schema" = "http://json-schema.org/draft-04/schema#",
        "additionalProperties" = true,
        "description" = "Updates a Single Row in a Data Table",
        "properties" = {
            "AttributeName" = {
                "description" = "The attribute name to update in the table",
                "type" = "string"
            },
            "AttributeValue" = {
                "description" = "The attribute value to write in the table",
                "type" = "string"
            },
            "DataTableId" = {
                "type" = "string"
            }
        },
        "title" = "Update a single attribute in the generic attribute table.",
        "type" = "object"
    })
    contract_output = jsonencode({
        "additionalProperties" = true,
        "properties" = {},
        "type" = "object"
    })
    
    config_request {
        request_template     = "{\"AttributeValue\": \"$${input.AttributeValue}\", \"key\": \"$${input.AttributeName}\"}"
        request_type         = "PUT"
        request_url_template = "/api/v2/flows/datatables/$${input.DataTableId}/rows/$${input.AttributeName}"
        headers = {
            Content-Type = "application/json"
        }
    }

    config_response {
        success_template = "$${rawResult}"
    }
}