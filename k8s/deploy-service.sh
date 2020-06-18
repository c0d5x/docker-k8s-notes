
# Create the deployment file
cat << EOF > deployment.yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hello-world
spec:
  selector:
    matchLabels:
      run: load-balancer-example
  replicas: 2
  template:
    metadata:
      labels:
        run: load-balancer-example
    spec:
      containers:
        - name: hello-world
          image: gcr.io/google-samples/node-hello:1.0
          ports:
            - containerPort: 8080
              protocol: TCP
EOF

kubectl apply -f ./deployment.yml

kubectl get deployment hello-world
kubectl describe deployment hello-world

kubectl get replicaset hello-world-.....
kubectl describe replicaset hello-world-....


