resource "civo_object_store_credential" "tf_state_creds" {
  name              = "tf-os-creds"
  access_key_id     = "adrise-access-key"
  secret_access_key = "adrise-secret-key"
}

data "civo_object_store_credential" "ds_tf_state_creds" {
  name       = "tf-os-creds"
  depends_on = [civo_object_store_credential.tf_state_creds]
}

resource "civo_object_store" "tf_os_state" {
  name          = "tf-os-state"
  max_size_gb   = 500
  region        = "LON1"
  access_key_id = data.civo_object_store_credential.ds_tf_state_creds.access_key_id
  depends_on    = [data.civo_object_store_credential.ds_tf_state_creds]
}