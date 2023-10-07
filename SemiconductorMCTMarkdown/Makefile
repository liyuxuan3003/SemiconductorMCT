PROJECT:=SemiconductorMCT

BUILD_DIR:=build

OUTPUT:=${BUILD_DIR}/${PROJECT}.pdf

FLAGS:=-b

MDS:=\
	${PROJECT}.md \
	Chapter01.md

default: ${BUILD_DIR} ${OUTPUT}
	@echo Makefile: Done!

${OUTPUT}: ${MDS}
	MarkdownPDF.py ${FLAGS} ${PROJECT}.md 

${BUILD_DIR}:
	mkdir -p ${BUILD_DIR}

run: ${OUTPUT}
	start ${OUTPUT}

clean:
	rm ${BUILD_DIR}/${PROJECT}.pdf

output:
	@echo ${OUTPUT}