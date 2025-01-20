<!-- minikube profile minikube-cluster -->
kubectl -n argocd port-forward service/argocd-server 8080:80