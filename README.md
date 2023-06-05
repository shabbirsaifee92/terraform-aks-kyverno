# terraform-aks-kyverno

## Deploy kyverno and policies
1. `helm repo add kyverno https://kyverno.github.io/kyverno/`
1. `helm repo update`
1. `helm install kyverno kyverno/kyverno -n kyverno --create-namespace`
1. Deploy spot toleration policy `kubectl apply -f kyverno-policy.yaml -n kyverno`
