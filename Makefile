.PHONY : serve
serve :
	mkdocs serve

.PHONY : clean_all
clean_all :
	cd sim   && make clean && cd ..
	cd ip    && make clean && cd ..
	cd build && make clean && cd ..