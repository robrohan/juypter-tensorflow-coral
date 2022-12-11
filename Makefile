REPO=robrohan

build:
	docker build -t $(REPO)/juypter-tensorflow-coral .

test:
	docker run --rm \
		-v $(PWD)/work:/home/jovyan/work \
		-p 8888:8888 \
		$(REPO)/juypter-tensorflow-coral
