build:
	TAG=`git rev-parse --short=8 HEAD`; \
	docker build --rm -f build-tanzu-workshop.dockerfile -t fcarta29/build-tanzu-workshop:$$TAG .; \
	docker tag fcarta29/build-tanzu-workshop:$$TAG fcarta29/build-tanzu-workshop:latest

clean:
	docker stop build-tanzu-workshop
	docker rm build-tanzu-workshop

rebuild: clean build

#ADD this back in with project examples are ready -v $$PWD/deploy:/deploy 
run:
	docker run --name build-tanzu-workshop -v $$PWD/config/kube.conf:/root/.kube/config -v $$PWD/labs:/labs -td fcarta29/build-tanzu-workshop:latest
	docker exec -it build-tanzu-workshop bash -l

join:
	docker exec -it build-tanzu-workshop bash -l
start:
	docker start build-tanzu-workshop
stop:
	docker stop build-tanzu-workshop

default: build
