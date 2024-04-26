resource "civo_object_store_credential" "tf-state-creds" {
    name = "tf-os-creds"
    access_key_id = "adrise-access-key"
    secret_access_key = "adrise-secret-key"
}

data "civo_object_store_credential" "tf-state-creds" {
    name = "tf-os-creds"
    depends_on = [civo_object_store_credential.tf-state-creds]
}

resource "civo_object_store" "tf-os" {
    name = "tf-state"
    max_size_gb = 500
    region = "LON1"
    access_key_id = civo_object_store_credential.tf-state-creds.access_key_id
    depends_on = [civo_object_store_credential.tf-state-creds]
}