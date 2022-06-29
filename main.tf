resource "genesyscloud_integration_action" "action" {
    name           = var.action_name
    category       = var.action_category
    integration_id = var.integration_id
    secure         = var.secure_data_action
    
    contract_input  = jsonencode({
        "$schema" = "http://json-schema.org/draft-04/schema#",
        "additionalProperties" = true,
        "description" = "using this to update the table",
        "properties" = {
            "DatatableId" = {
                "description" = "Data Table ID",
                "type" = "string"
            },
            "Key" = {
                "description" = "Which key to update",
                "type" = "string"
            },
            "StringFieldName1" = {
                "type" = "string"
            },
            "StringFieldName2" = {
                "type" = "string"
            },
            "StringFieldName3" = {
                "type" = "string"
            },
            "BoolFieldName1" = {
                "type" = "string"
            },
            "BoolFieldName2" = {
                "type" = "string"
            },
            "BoolFieldName3" = {
                "type" = "string"
            },
            "IntFieldName1" = {
                "type" = "string"
            },
            "IntFieldName2" = {
                "type" = "string"
            },
            "IntFieldName3" = {
                "type" = "string"
            },
            "StringFieldValue1" = {
                "type" = "string"
            },
            "StringFieldValue2" = {
                "type" = "string"
            },
            "StringFieldValue3" = {
                "type" = "string"
            },
            "BoolFieldValue1" = {
                "type" = "boolean"
            },
            "BoolFieldValue2" = {
                "type" = "boolean"
            },
            "BoolFieldValue3" = {
                "type" = "boolean"
            },
            "IntFieldValue1" = {
                "type" = "integer"
            },
            "IntFieldValue2" = {
                "type" = "integer"
            },
            "IntFieldValue3" = {
                "type" = "integer"
            }
        },
        "required" = [
            "Key",
            "DatatableId"
        ],
        "title" = "Update Table",
        "type" = "object"
    })
    contract_output = jsonencode({
        "additionalProperties" = true,
        "properties" = {},
        "type" = "object"
    })
    
    config_request {
    request_template     = "{\n    \"key\":\"$${input.Key}\"\n#if(\"$!{input.StringFieldName1}\" != \"\")\n    ,\"$!{input.StringFieldName1}\": \"$!{input.StringFieldValue1}\"\n#end\n#if(\"$!{input.StringFieldName2}\" != \"\")\n    ,\"$!{input.StringFieldName2}\": \"$!{input.StringFieldValue2}\"\n#end\n#if(\"$!{input.StringFieldName3}\" != \"\")\n    ,\"$!{input.StringFieldName3}\": \"$!{input.StringFieldValue3}\"\n#end\n\n#if(\"$!{input.IntFieldName1}\" != \"\" && \"$!{input.IntFieldValue1}\" != \"\")\n    ,\"$!{input.IntFieldName1}\": $!{input.IntFieldValue1}\n#end\n#if(\"$!{input.IntFieldName2}\" != \"\" && \"$!{input.IntFieldValue2}\" != \"\")\n    ,\"$!{input.IntFieldName2}\": $!{input.IntFieldValue2}\n#end\n#if(\"$!{input.IntFieldName3}\" != \"\" && \"$!{input.IntFieldValue3}\" != \"\")\n    ,\"$!{input.IntFieldName3}\": $!{input.IntFieldValue3}\n#end\n\n#if(\"$!{input.BoolFieldName1}\" != \"\")\n    ,\"$!{input.BoolFieldName1}\": $!{input.BoolFieldValue1}\n#end\n#if(\"$!{input.BoolFieldName2}\" != \"\")\n    ,\"$!{input.BoolFieldName2}\": $!{input.BoolFieldValue2}\n#end\n#if(\"$!{input.BoolFieldName3}\" != \"\")\n    ,\"$!{input.BoolFieldName3}\": $!{input.BoolFieldValue3}\n#end\n}"
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