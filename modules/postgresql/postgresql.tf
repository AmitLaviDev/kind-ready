resource "helm_release" "postgresql" {
  name             = "postgresql-ha"
  repository       = "https://charts.bitnami.com/bitnami"
  chart            = "postgresql-ha"
  namespace        = "default"
  create_namespace = true
  timeout          = 300

  set {
    name  = "username"
    value = "root"
  }

  set {
    name  = "password"
    value = "fuko09phsurxho"
  }

  set {
    name  = "postgresql.replicaCount"
    value = "1"
  }

}