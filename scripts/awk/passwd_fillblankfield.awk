BEGIN{
	FS=":"
}
{
	for (i=1; i<=NF; i++){
		if ($i==""){
			printf("%s:", "NONE")
		}
		if (i == NF){
			printf("%s", $i)
		}else{
			printf("%s:", $i)
		}
	}
	printf("%s","\n")
}

