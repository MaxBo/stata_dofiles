*! 1.0.1  14mar2000  jw/ics
program define fwrite
	version 14
	* write line of text to file with filename fn
	* use option replace to replace, otherwise, it is appended
	args fn text
	syntax anything [, replace]
	
	if "`replace'" == "" {
		local replace="append"
	}
	file open myfile using "`fn'", write `replace'
    file write myfile "`text'" _n
	file close myfile
    	
end
