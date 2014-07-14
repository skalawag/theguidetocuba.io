build:
	./site ./content.md > ./public/index.html

server:
	ruby -run -e httpd ./public -p 4000
