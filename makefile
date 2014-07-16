clone:
	git clone git@github.com:frodsan/theguidetocuba.io.git -b gh-pages website

build:
	./site ./content.md > ./website/online.html

publish:
	./bin/publish ./website

server:
	ruby -run -e httpd ./website -p 4000
