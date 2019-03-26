valido=""

while [[ $valido == "" ]]; do
	read -p "Por favor introduzca el nombre del archivo a procesar" archivo
	valido=`ls | grep -w $archivo`
	if [[ $valido == "" ]]; then
		echo El archivo no existe intentelo otra vez
	fi
done

numGrupos=0
while read linea; do
	numGrupos=$(($numGrupos+1))
done < $archivo

echo "En el fichero tenemos" $numGrupos "grupos"

maxUsuarios=0
maxGrupo=""
maxGrupos=""
onGrupos=false
while read linea; do
	campo=entrada
	numCampo=1
	
	while [[ ! $campo == "" ]]; do
		nombreGrupo=`echo $linea | awk '{print $1}'`
		campo=`echo $linea | awk -v col="$numCampo" '{print $col}'`
		numCampo=$(($numCampo+1))
	done
	numUsuarios=$((numCampo-3))
	if [[ $numUsuarios -gt $maxUsuarios ]]; then
		maxUsuarios=$numUsuarios
		maxGrupo=$nombreGrupo
		maxGrupos=${nombreGrupo:0:-1}
		onGrupos=false
	elif [[ $numUsuarios -eq $maxUsuarios ]]; then
		maxGrupos="$maxGrupos ${nombreGrupo:0:-1}"
		onGrupos=true
	fi
	echo $nombreGrupo $numUsuarios usuarios

done < $archivo

if [[ $onGrupos = true ]]; then
	echo Los grupos con mas usuarios son $maxGrupos
else
	echo El grupo con mas usuarios es ${maxGrupo:0:-1}
fi
