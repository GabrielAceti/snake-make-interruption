		ORG 	00	;PONTO DE INICIO DO PROGRAMA
		JMP	start	;PULA PARA O INICIO DO PROGRAMA
		DB	20	;PRIMEIRO VETOR DE INTERRUP��O (INT 02)
		DB	30	;SEGUNDO VETOR DE INTERRUP��O (INT 03)
		DB	40	;TERCEIRO VETOR DE INTERRUP��O (INT 04)
start:	
		MOV 	AL,FF
		OUT 	04	;REINICIA O JOGO DO LABIRINTO
		MOV 	AL,00 	;REINICIA AL
	 	MOV	BL,40	;BL RECEBE 01000000 (P/ BAIXO)
		MOV	CL,01	;CL RECEBE 01 (VEL. MINIMA)
		OUT 	08	;MOSTRA O PAD NUMERICO
		STI		;HABILITA AS INTERRUP��ES
loop:
		NOP		;N�O FAZ NADA
		JMP	loop	;RETORNA PARA O LOOP

		ORG	20	;ROTINA DO TIMER
		CLI		;DESABILITA AS INTERRUP��ES
		MOV	AL,00	;LIMPA AL
		OR	AL,BL	;AJUSTA A DIRECAO
		OR	AL,CL	;AJUSTA A DISTANCIA
		OUT	04	;ENVIA O DADO PARA A PORTA 04
		STI		;HABILITA AS INTERRUP��ES
		IRET

		ORG	30	;ROTINA DO KEYBOARD
		IRET		;RETORNA PARA O INICIO

		ORG	40	;ROTINA DO PAD NUMERICO
		CLI		;DESABILITA AS INTERRUP��ES
		IN 	08	;PASSA O VALOR DIGITADO NO PAD NUMERICO PARA AL
		CMP	AL,32	;VERIFICA SE O NUMERAL 2 FOI DIGITADO
		JNZ	esq	;CASO N�O TENHA SIDO DIGITADO, PULA PARA A PROXIMA COMPARA��O
		MOV	BL,40	;BL RECEBE 01000000 (P/ BAIXO)
		JMP	back	;RETORNA PARA O COME�O
esq:
		CMP	AL,34	;VERIFICA SE O NUMERAL 4 FOI DIGITADO
		JNZ	dir	;CASO N�O TENHA SIDO DIGITADO, PULA PARA A PROXIMA COMPARA��O
		MOV	BL,20	;BL RECEBE 100000 (P/ ESQUERDA)
		JMP	back
dir:		
		CMP	AL,36	;VERIFICA SE O NUMERAL 4 FOI DIGITADO
		JNZ	cima	;CASO N�O TENHA SIDO DIGITADO, PULA PARA A PR�XIMA COMPARA��O
		MOV 	BL,10	;BL RECEBE 10000 (P/ DIREITA)
		JMP	back
cima:	
		CMP	AL,38	;VERIFICA SE O NUMERAL 8 FOI DIGITADO
		JNZ	velup	;CASO N�O TENHA SIDO DIGITADO, PULA PARA A PROXIMA COMPARA��O
		MOV	BL,80	;BL RECEBE 100000000 (P/ CIMA)
		JMP	back
velup:		
		CMP	AL,39	;VERIFICA SE O NUMERAL 9 FOI DIGITADO
		JNZ	veldown ;CASO N�O TENHA SIDO DIGITADO, PULA PARA A PR�XIMA COMPARA��O
		CMP	CL,08	;VERIFICA SE J� N�O EST� NA VELOCIDADE M�XIMA
		JZ	back	;CASO ESTEJA, RETORNA
		SHL	CL	;AUMENTA A VELOCIDADE
		JMP	back	;RETORNA PARA O COME�O
veldown:
		CMP	AL,33	;VERIFICA SE O NUMERAL 3 FOI DIGITADO
		JNZ	restart	;CASO N�O TENHA SIDO DIGITADO, PULA PARA A PR�XIMA COMPARA��O
		CMP	CL,01	;VERIFICA SE J� N�O EST� NA VELOCIDADE M�NIMA
		JZ	back	;CASO ESTEJA, RETORNA
		SHR	CL	;REDUZ A VELOCIDADE
		JMP	back	;RETORNA PARA O COME�O
restart:
		CMP	AL,35	;VERIFICA SE O NUMERAL 5 FOI DIGITADO
		JNZ	fim	;CASO N�O TENHA SIDO DIGITADO, PULA PARA A PR�XIMA COMPARA��O
		MOV	AL,FF	;REINICIAR O JOGO
		MOV	BL,40	;BL RECEBE 01000000 (P/ BAIXO)
		MOV	CL,01	;CL RECEBE 01 (VEL. MINIMA)
		OUT	04	;ENVIA AL PARA A PORTA 04
		JMP 	back	;RETORNA PARA O COME�O
fim:
		CMP	AL,30	;VERIFICA SE O NUMERAL 0 FOI DIGITADO
		JNZ	back	;CASO N�O TENHA SIDO DIGITADO, RETORNA PARA O COME�O
		HALT		;ENCERRA O PROGRAMA
back:
		STI		;HABILITA AS INTERRUP��ES
		IRET		;RETORNA PARA O COME�O
END



