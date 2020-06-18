kubectl config view
kubectl cluster-info

# deployment
kubectl apply -f ./mydeploymentfile.yml
kubectl diff -f ./mydeploymentfile.yml
kubectl create deployment nginx --image=nginx

kubectl get deployment mydeployment
kubectl describe deployment mydeployment
kubectl delete deployment mydeployment
kubectl expose deployment mydeployment --type=LoadBalancer --name=mydeployment

kubectl autoscale deployment mydeployment --min=2 --max=10

kubectl rollout status deployment mydeployment
kubectl rollout restart deployment mydeployment

# nodes
kubectl get nodes
kubectl describe nodes
kubectl get node --selector='!node-role.kubernetes.io/master'

# services
kubectl get services
kubectl get services --sort-by=.metadata.name
kubectl get pod,svc -n kubernetes-dashboard
kubectl get pod,svc --all-namespaces
kubectl describe services
kubectl delete service mydeployment

# logs
kubectl logs -l app=nginx
kubectl logs -f -l app=elasticsearch --max-log-requests 7
# print logs of exited container
kubectl logs nginx-78f5d695bd-czm8z -p
# from a specific datetime
kubectl logs nginx-78f5d695bd-czm8z --since=1h
kubectl logs nginx-78f5d695bd-czm8z --since-time=2019-11-01T15:00:00Z

# events
kubectl get events
kubectl get events --sort-by=.metadata.creationTimestamp
kubectl get events mypod.timestamp

# labels
kubectl label pods mypod new-label=awesome

# pods
kubectl get pods --show-labels
kubectl get pods --all-namespaces
kubectl get pods -o wide
kubectl get pods --sort-by='.status.containerStatuses[0].restartCount'
kubectl describe pod mypod
kubectl get pod,svc -n kubernetes-dashboard
kubectl get pod,svc --all-namespaces
kubectl delete pod mypod

kubectl exec mypod -- ls /
# when pod has more than one container
kubectl exec -i -t mypod --container main-app -- /bin/bash

kubectl run -i --tty busybox --image=busybox -- sh
kubectl run nginx --image=nginx --restart=Never -n mynamespace


# replicasets
kubectl get replicaset
kubectl describe replicaset

# port forwards
kubectl port-forward hello-world-... 8080:8080
kubectl port-forward pod/mypod 5000 5000
kubectl port-forward deployment/mydeployment 6000 6000

# PV, PVC
kubectl get pv
kubectl describe pv
kubectl get pvc
kubectl describe pvc

