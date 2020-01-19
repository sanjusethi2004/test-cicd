data "template_file" "certificate" {
  template = "$file(${path.module}/templates/kubernetes-csr.json})"
  depends_on = ["aw"]
}