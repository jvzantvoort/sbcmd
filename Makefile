
NAME ?= "jvzantvoort/sbcmd:1"
UID  ?= $(shell id -u)
GID  ?= $(shell id -g)

.PHONY: build test

build:
	docker rmi $(NAME) || echo "oke"
	docker build -t $(NAME) --file Dockerfile --rm .

test:
	docker run --rm -v $$PWD:/code --mount type=tmpfs,destination=/output -i $(NAME) sphinx srcdir=test uid=$(UID) gid=$(GID)
