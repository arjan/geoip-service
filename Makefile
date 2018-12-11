tag := gcr.io/botsquad1/geoip-service:$(shell vsntool)

image:
	docker build . -t $(tag)
	docker push $(tag)
