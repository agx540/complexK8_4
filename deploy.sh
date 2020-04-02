# SHA is an environment variable in travis environment. see .travis.yml file
docker build -t alexsnyx/multi-client:latest -t alexsnyx/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alexsnyx/multi-server:latest -t alexsnyx/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t alexsnyx/multi-worker:latest -t alexsnyx/multi-worker:$SHA -f ./worker/Dockerfile ./worker

# you need to push the image for each tag
docker push alexsnyx/multi-client:latest
docker push alexsnyx/multi-server:latest
docker push alexsnyx/multi-worker:latest

# you need to push the image for each tag
docker push alexsnyx/multi-client:$SHA
docker push alexsnyx/multi-server:$SHA
docker push alexsnyx/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=alexsnyx/multi-server:$SHA
kubectl set image deployments/client-deployment client=alexsnyx/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=alexsnyx/multi-worker:$SHA