private
compileCodeString: codeString
	| methodName methodBody |
	methodName := 'compiled{1}' format: { self hash }.
	methodBody := methodName , String cr , '^ ', codeString.
	TTCompiledTasks class compile: methodBody classified: 'private-compiled'.
	^ TTCompiledTasks perform: methodName asSymbol