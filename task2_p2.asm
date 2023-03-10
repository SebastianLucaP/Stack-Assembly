section .text
	global par
	extern printf

;; int par(int str_length, char* str)
;
; check for balanced brackets in an expression

;Adauga 4 la adresa lui esp pentru a sari peste return, apoi dau pop la numarul de paraanteze in ecx si la adresa sirului de paranteze in edx
par:
	add esp, 4
	xor esi, esi
	xor edi, edi
	add esi, 8
	pop ecx
	pop edx
	xor esi, esi
;Parcurge sirul de paranteze si aduna 1 in edi pentru fiecare paranteza deschisa si scade 1 pentru fiecare paranteza inchisa
;Secventa de paranteze este corecta daca in edi se afla valoarea 0 si incorecta daca se afla orice alta valoare
string:
	cmp [edx+esi], byte 40
	je addedi
	jmp subedi
;Adauga 1 in edi, in caz ca paranteza este deschisa
addedi:
	add edi, 1
	jmp skip
;Scade 1 din edi, in caz ca paranteza este inchisa
;Daca edi ajunge sub 0 secventa nu este corecta tratand cazul in care avem ")("
subedi:
	sub edi, 1
	cmp edi, 0
	jl notbalanced
skip:
	add esi, 1
	loop string
;Daca edi este 0 secventa este corecta si pune 1 in eax, iar daca este diferit de 0 in eax ramane valoarea 0
notbalanced:
	xor eax, eax
	cmp edi, 0
	je correct
	jmp skip2
correct:
	add eax, 1
;Scade 12 din adresa lui esp pentru a ajunge inapoi la return
skip2:
	sub esp, 12
	ret
