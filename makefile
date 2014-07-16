build:
	./site ./content.md > ./website/online.html

publish:
	git submodule foreach git add -A .
	git submodule foreach git commit -m 'Updates'
	git submodule foreach git pull origin gh-pages
	git submodule foreach git push origin gh-pages

server:
	ruby -run -e httpd ./website -p 4000
