section .text
	global cmmmc

;; int cmmmc(int a, int b)
;
;; calculate least common multiple fow 2 numbers, a and b

;Adauga 4 la adresa lui esp pentru a sari peste return, apoi dau pop la numerele a si b in eax si edx
;Adauga valorea lui eax in ecx pentru a putea face inmultirea numerelor in eax
cmmmc:
	add esp, 4
	pop eax
	pop edx
	xor ecx, ecx
	add ecx, eax
	imul eax, edx
;Calculeaza cel mai mare divizor comun scazand din numarul mai mare pe cel mai mic pana cand acestea devin egale
cmmdc:
	cmp ecx, edx
	je findcmmmc
	cmp ecx, edx
	jg subeax
	jmp subedx
;Scade din a pe b in cazul in care acesta este mai mare
subeax:
	sub ecx, edx
	jmp cmmdc
;Scade din b pe a in cazul in care acesta este mai mare
subedx:
	sub edx, ecx
	jmp cmmdc
;Calculeaza cmmmc cu formula cmmmc=(a*b)/cmmdc
;Scade 12 din adresa lui esp pentru a ajunge inapoi la return
findcmmmc:
	xor edx, edx
	idiv ecx
	sub esp, 12
	ret
