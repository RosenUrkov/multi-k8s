docker build -t rosenurkov/multi-client:latest -t rosenurkov/multi-client:$SHA -f client/Dockerfile ./client
docker build -t rosenurkov/multi-server:latest -t rosenurkov/multi-server:$SHA -f server/Dockerfile ./server
docker build -t rosenurkov/multi-worker:latest -t rosenurkov/multi-worker:$SHA -f worker/Dockerfile ./worker

docker push rosenurkov/multi-client:latest
docker push rosenurkov/multi-server:latest
docker push rosenurkov/multi-worker:latest

docker push rosenurkov/multi-client:$SHA
docker push rosenurkov/multi-server:$SHA
docker push rosenurkov/multi-worker:$SHA

kubectl apply -f ./k8s

kubectl set image deployments/client-deployment  client=rosenurkov/multi-client:$SHA
kubectl set image deployments/server-deployment  server=rosenurkov/multi-server:$SHA
kubectl set image deployments/worker-deployment  worker=rosenurkov/multi-worker:$SHA
