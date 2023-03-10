section .text
	global sort

; struct node {
;     	int val;
;    	struct node* next;
; };

;; struct node* sort(int n, struct node* node);
; 	The function will link the nodes in the array
;	in ascending order and will return the address
;	of the new found head of the list
; @params:
;	n -> the number of nodes in the array
;	node -> a pointer to the beginning in the array
; @returns:
;	the address of the head of the sorted list

;Copiaza in ecx numarul de noduri, iar in eax adresa vectorului
;Muta in esi valoare din primul nod pentru a calcula apoi valoarea minima din vectorul de noduri
sort:
	enter 0, 0
	mov ecx, [ebp+8]
	mov eax, [ebp+12]
	mov edi, 8
	mov esi, [eax]
	sub ecx, 1
;Compara minimul curent cu valorile din vector
min:
	cmp esi, [eax+edi]
	jg newmin
	jmp skip
;In cazul unei valori mai mici aceasta este salvata in esi, iar "n"-ul de la adresa de forma [eax+n] la care se afla valoarea minima in edx
newmin:
	mov esi, [eax+edi]
	mov edx, edi
skip:
	add edi, 8
	loop min
;Da push la "n" pentru a retine adresa valorii minime pe stiva
;Da push din nou la "n" si la valoarea minima pe stiva pentru a avea 2 campuri pentru o valoare minima anterioara si adresa acesteia in cadrul algoritmului de sortare
;Da push o ultima data la "n" si la valoare pentru a avea pe stiva valoarea minima curenta si adresa acesteia in cadrul algoritmului de sortare
	push edx
	mov edx, [esp]
	push edx
	push esi
    mov edx, [esp+4]
	mov esi, [esp]
	push edx
	push esi
;Copiaza din nou numarul de noduri in ecx si prima valoare in esi pentru a calcula valoarea maxima
;Calculeaza valoarea maxima din vectorul de noduri si ii da push pe stiva
	mov ecx, [ebp+8]
	mov edi, 8
	mov esi, [eax]
	sub ecx, 1
;Compara maximul curent cu valorile din vector
max:
	cmp esi, [eax+edi]
	jl newmax
	jmp skip2
;In cazul unei valori mai mari aceasta este salvata in esi
;Da push la valoarea maxima pe stiva
newmax:
	mov esi, [eax+edi]
skip2:
	add edi, 8
	loop max
	push esi
;Muta in ecx numarul de noduri pentru a realiza sortarea
;Pentru fiecare nod parcurge restul nodurilor si cauta urmatorul nod cu valoarea cea mai mica, dar mai mare decat a nodului curent si face legatura intre acestea
	mov ecx, [ebp+8]
	sub ecx, 1
;Da push la valoarea lui ecx si copiaza in ecx numarul de noduri pentru a realiza parcurgerea tuturor nodurilor pentru nodul curent
;Muta in edi valoarea maxima pentru a gasi valorea minima si in esi valoarea minimului anterior
allnodes:
	push ecx
	mov ecx, [ebp+8]
	xor edx, edx
	mov edi, [esp+4]
	mov esi, [esp+16]
;Gaseste valoarea minima din vector mai mare decat a nodului pentru care se va realiza legatura cu urmatorul nod
sortlist:	
	cmp [eax+edx], edi
	jg skip3
	cmp [eax+edx], esi
	jg minnode
	jmp skip3
;Pune pe stiva noua valoare minima curenta si "n"-ul din adresa acesteia
minnode:
	mov [esp+12], edx
	push edi
	mov edi, [eax+edx]
	mov [esp+12], edi
	pop edi
	mov edi, [eax+edx]
skip3:

	add edx, 8
	loop sortlist
;Da pop in ecx pentru a reveni la contorul anterior cu care se parcurg toate nodurile pentru a fi sortare
	pop ecx
;Muta in campul de next al nodului adresa urmatorului nod gasit 
	mov esi, [esp+8]
	lea edi, [eax+esi]
	mov edx, [esp+16]
	add eax, edx
	mov [eax+4], edi
	sub eax, edx
;Pune pe stiva valoarea si "n-ul" nodului curent in campurile pentru nodul anterior pentru a fi folosite mai departe
	mov edx, [esp+4]
	mov [esp+12], edx
	mov edx, [esp+8]
	mov [esp+16], edx
	loop allnodes
;Adauga in eax "n-ul" adresei nodului cu valoarea minima pentru ca acesta sa pointeze la nodul cu valoarea minima 
	mov edx, [esp+20]
	add eax, edx

	leave
	ret
