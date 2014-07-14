build:
	./site ./content/english.md > ./public/english.html

server:
	ruby -run -e httpd ./public -p 4000
