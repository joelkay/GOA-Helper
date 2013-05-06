// AbyssDragon's Library

proc/BubbleSort(list/L)
	for(var/i = L.len; i >= 1; i--)
		for(var/j = 1; j < i; j++)
			if(Compare(L[j], L[j+1]) == -1)
				Swap(L, j, j+1)
	//return L
proc/CountingSort(list/L, max_element=100)
	var/LCopy[] = L.Copy()
	var/TempList[max_element+1]
	for(var/j in 1 to LCopy.len)
		TempList[LCopy[j]+1]++
	for(var/i in 2 to max_element+1)
		TempList[i] = TempList[i] + TempList[i-1]
	for(var/j = L.len; j > 0; j--)
		L[TempList[LCopy[j]+1]] = LCopy[j]
		TempList[LCopy[j]+1]--
	//return LCopy

proc/Compare(item1, item2)
	if(isnum(item1))
		return item2<item1?-1:(item1==item2?0:1)
	else
		return sorttextEx("[item1]", "[item2]")

proc/Swap(list/L, position1, position2)
	var/temp = L[position1]
	L[position1] = L[position2]
	L[position2] = temp