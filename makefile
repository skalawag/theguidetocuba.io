build:
	./site ./content.md > ./website/online.html

publish:
	git submodule foreach git add -A .
	git submodule foreach git commit -m 'Updates'
	git submodule foreach git pull
	git submodule foreach git push

server:
	ruby -run -e httpd ./website -p 4000
