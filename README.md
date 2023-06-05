# terraform-aks-kyverno

## Deploy kyverno and policies
1. `helm repo add kyverno https://kyverno.github.io/kyverno/`
1. `helm repo update`
1. `helm install kyverno kyverno/kyverno -n kyverno --version 2.7.3 kyverno_values.yaml`
1. Deploy spot toleration policy `kubectl apply -f kyverno-policy.yaml -n kyverno`
1. Wait for kyverno to be ready and deploy test pod `kubectl run nginx --image=nginx -n default`
