microk8s kubectl port-forward service/contapa2-m2-kc 80:80 --address='0.0.0.0' &
microk8s kubectl port-forward service/contanode-m2-kc 3000:3000 --address='0.0.0.0' &
