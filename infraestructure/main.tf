provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "todo_app" {
  metadata {
    name = "todo-app"
  }
}
