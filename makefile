build:
	./site ./content.md > ./website/online.html

server:
	ruby -run -e httpd ./website -p 4000
