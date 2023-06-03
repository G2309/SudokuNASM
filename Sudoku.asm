; Universidad del Valle de Guatemala			Organización de Computadoras y Assembler
; Gustavo Cruz # 22779							Edwin de Leon # 22809
; Descripción: Sudoku NASM
; Consultado en: 
; 1. https://www.youtube.com/watch?v=0_CW2-RMw0w
; 2. https://www.tutorialspoint.com/assembly_programming/index.htm


section .data									;sección de variables
	msgBienvenida			db "Bienvenido a SUDOKU-NASM", 10
	msg_LenBienven			equ $ - msgBienvenida
	msgIns					db "Instrucción: Debes ingresar numeros de tal forma que en cada linea horizontal, vertical y cuadrante al que pertenezca no se repiten los números del 1 al 9", 10
	msg_LenIns				equ $ - msgIns
	msgDif					db "Oprima 1 para continuar", 10
	msg_LenDif				equ $ - msgDif
	msgCol					db "^ |A|", "B|", "C|", "D|", "E|", "F|", "G|", "H|", "I|"
	msg_LenCol				equ $ - msgCol
	msgNewRow					db " ",10
	msg_LenRow				equ $ - msgNewRow
	msgElRow				db "Elige una fila: ",10
	msg_LenElRow			equ $ - msgElRow
	msgElCol				db "Elige una columna: ",10
	msg_LenElCol			equ $ - msgElCol
	msgContinuar			db "¿Desea seguir ingresando datos? [S/N]",10
	msg_LenContinuar		equ $ - msgContinuar
	msgTab					db "	",0
	msg_LenTab				equ $ - msgTab
	msgInCol				db "Ingrese la columna a la cuál desea ingresar un valor: ",10
	msg_LenInCol			equ $ - msgInCol
	msgInRow				db "Ingrese la fila a la cuál desea ingresar un valor",10
	msg_LenInRow			equ $ - msgInRow
	msgCambio				db "Ingrese el valor que desea ingresar: ",10
	msg_LenInCambio			equ $ - msgCambio
	direccion				db 0
	
	sudoku3_r1				db "1 |",
							db "0", 
							db "|", 
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",
							db "3",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",10
							db "2 |",
							db "0",
							db "|",
							db "0", 
							db "|",
							db "3",
							db "|",
							db "0",
							db "|", 
							db "0",
							db "|", 
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",10
							db "3 |",
							db "0",
							db "|",
							db "9",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",10
							db "4 |",
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",
							db "2",
							db "|",
							db "0",
							db "|",10
							db "5 |",
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",
							db "4",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",10
							db "6 |",
							db "0",
							db "|",
							db "1",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",10
							db "7 |",
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",
							db "4",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",10
							db "8 |",
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",10
							db "9 |",
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|",
							db "0",
							db "|", 
							db "0",
							db "|"

	sudoku_size				equ 21

section .bss				;sección de variables no inicializadas
	input					resb 2
	inputCol				resb 2
	inputRow				resb 2
	inputCam				resb 2

section .text
	global _start
	
_start: 
	
	;Imprime Bienvenida
	mov eax, 4
	mov ebx, 1
	mov ecx, msgBienvenida
	mov edx, msg_LenBienven
	
	;Llamada al kernel
	int 0x80
	
	;Imprime Instrucción
	mov eax, 4
	mov ebx, 1
	mov ecx, msgIns
	mov edx, msg_LenIns
	
	;Llamada al kernel
	int 0x80
	
	;Agregar las instruciones para jugar sudoku y no morir en el intento
	
	;Preguntar por la dificultad
	mov eax, 4 
	mov ebx, 1
	mov ecx, msgDif
	mov edx, msg_LenDif
	
	;Llamada al kernel
	int 0x80
	
	mov eax, 3
	mov ebx, 0
	mov ecx, input
	mov edx, 2
	
	;Llamada al kernel
	int 0x80
	
	cmp byte [input], "1"
	je Sudo									; Salta si es igual a 1, es dificultad fácil
	jne Fin
	
Sudo:
	;Imprimir las columnas para servir como guía
	mov eax, 4
	mov ebx, 1
	mov ecx, msgCol
	mov edx, msg_LenCol
	int 0x80
	
	mov eax, 4
	mov ebx, 1
	mov ecx, msgNewRow
	mov edx, msg_LenRow
	int 0x80
	
	mov eax, 4
	mov ebx, 1
	mov ecx, sudoku3_r1
	mov edx, 197
	int 0x80
	
	mov eax, 4
	mov ebx, 1
	mov ecx, msgNewRow
	mov edx, msg_LenRow
	int 0x80
	
	mov eax, 4
	mov ebx, 1
	mov ecx, msgInCol
	mov edx, msg_LenInCol
	int 0x80
	
	mov eax, 3
	mov ebx, 0
	mov ecx, inputCol
	mov edx, 2
	int 0x80
	
	mov eax, 4
	mov ebx, 1
	mov ecx, msgInRow
	mov edx, msg_LenInRow
	int 0x80
	
	mov eax, 3
	mov ebx, 0
	mov ecx, inputRow
	mov edx, 2
	int 0x80
	
	mov eax, 4
	mov ebx, 1
	mov ecx, msgCambio
	mov edx, msg_LenInCambio
	int 0x80
	
	mov eax, 3
	mov ebx, 0
	mov ecx, inputCam
	mov edx, 2
	int 0x80
	call Col
	call Row
	call Cam
	jmp Cont
	
Col:
	cmp byte [inputCol], "A"
	je A
	cmp byte [inputCol], "B"
	je B
	cmp byte [inputCol], "C"
	je C
	cmp byte [inputCol], "D"
	je D
	cmp byte [inputCol], "E"
	je E
	cmp byte [inputCol], "F"
	je F
	cmp byte [inputCol], "G"
	je G
	cmp byte [inputCol], "H"
	je H
	cmp byte [inputCol], "I"
	je I
	ret

Row:
	cmp byte [inputRow], "1"
	je r1
	cmp byte [inputRow], "2"
	je r2
	cmp byte [inputRow], "3"
	je r3
	cmp byte [inputRow], "4"
	je r4
	cmp byte [inputRow], "5"
	je r5
	cmp byte [inputRow], "6"
	je r6
	cmp byte [inputRow], "7"
	je r7
	cmp byte [inputRow], "8"
	je rr8
	cmp byte [inputRow], "9"
	je rr9
	ret

	;--------------------------------------------------------------------------------------
Cont:
	;Desea continuar?
	mov eax, 4
	mov ebx, 1
	mov ecx, msgContinuar
	mov edx, msg_LenContinuar
	
	;Llamada al kernel
	int 0x80
	
	mov eax, 3
	mov ebx, 0
	mov ecx, input
	mov edx, 2
	
	;Llamada al kernel
	int 0x80
	
	cmp byte [input], "S"
	mov eax, [direccion]
	imul eax, 0
	je Sudo
	jne Fin
	
Cam:
	movzx ebx, byte [direccion]
	mov ax, [inputCam]
	mov ecx, sudoku3_r1
	add ecx, ebx
	mov [ecx], ax
	ret

A:
	mov eax, [direccion]
	add eax, 1
	mov [direccion], eax
	ret
B:
	mov eax, [direccion]
	add eax, 3
	mov [direccion], eax
	ret
C:
	mov eax, [direccion]
	add eax, 5
	mov [direccion], eax
	ret
D:
	mov eax, [direccion]
	add eax, 7
	mov [direccion], eax
	ret
E:
	mov eax, [direccion]
	add eax, 9
	mov [direccion], eax
	ret
F:
	mov eax, [direccion]
	add eax, 11
	mov [direccion], eax
	ret
G:
	mov eax, [direccion]
	add eax, 13
	mov [direccion], eax
	ret
H:
	mov eax, [direccion]
	add eax, 15
	mov [direccion], eax
	ret
I:
	mov eax, [direccion]
	add eax, 19
	mov [direccion], eax
	ret
r1:
	mov eax, [direccion]
	mov ebx, 0
	mov ecx, 23
	imul ebx, ecx
	add eax, ebx
	mov [direccion], eax
	ret
	
r2:
	mov eax, [direccion]
	mov ebx, 1
	mov ecx, 23
	imul ebx, ecx
	add eax, ebx
	mov [direccion], eax
	ret
r3:
	mov eax, [direccion]
	mov ebx, 2
	mov ecx, 23
	imul ebx, ecx
	add eax, ebx
	mov [direccion], eax
	ret
r4:
	mov eax, [direccion]
	mov ebx, 3
	mov ecx, 23
	imul ebx, ecx
	add eax, ebx
	mov [direccion], eax
	ret
r5:
	mov eax, [direccion]
	mov ebx, 4
	mov ecx, 23
	imul ebx, ecx
	add eax, ebx
	mov [direccion], eax
	ret
r6:
	mov eax, [direccion]
	mov ebx, 5
	mov ecx, 23
	imul ebx, ecx
	add eax, ebx
	mov [direccion], eax
	ret
r7:
	mov eax, [direccion]
	mov ebx, 6
	mov ecx, 23
	imul ebx, ecx
	add eax, ebx
	mov [direccion], eax
	ret
rr8:
	mov eax, [direccion]
	mov ebx, 7
	mov ecx, 23
	imul ebx, ecx
	add eax, ebx
	mov [direccion], eax
	ret
rr9:
	mov eax, [direccion]
	mov ebx, 8
	mov ecx, 23
	imul ebx, ecx
	add eax, ebx
	mov [direccion], eax
	ret
	

Fin:
	;Finalizar ejecución
	mov eax, 1
	xor ebx, ebx
	int 0x80
