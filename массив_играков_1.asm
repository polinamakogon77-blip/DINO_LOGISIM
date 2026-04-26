	asect 0x00
	
	# массив играков аддресс 0хb4
	# массив указателей аддресс 0х9в
	# размер структуры 12 байт (4 - очки, 8 - имя)
	# новый игрок 0xc8
	

	
	# сравниваем значение играков => получаем адрресс начала ячейки для нового игрока
	ldi r0, 0xb4
	push r0
	jsr func
	
	#сдвиг играков
	ldi r1, 0xd8
	while
		ldi r0, 0xf0
		ld r0, r0
		cmp r1, r0
	stays nz
		ldi r2, -12
		add r2, r1
		push r1
		
		jsr shift
		pop r1
		
	wend
	
	# запись игрока
	ldi r0, 0xe4 # откуд
	
	ldi r1, 0xf0
	ld r1, r1
	
	ldi r2, 12
	while
		tst r2
	stays nz
		ld r0, r3
		st r1, r3
		
		inc r0
		inc r1
		dec r2
	wend
	
	halt

func:
	ldsa r1, 1
	ld r1, r1
	ld r1, r1
	
	ldi r0, 0xe4
	ld r0, r0
	
	if
		cmp r0, r1 # a > a_1
	is gt
		# адрес начала нового игрока
		br start_player
	else 
		if 
			cmp r0, r1 # a == a_1
		is z 
			ldi r0, 0xe5
			ld r0, r0
			
			ldsa r1, 1
			ld r1, r1
			inc r1
			ld r1, r1
			
			if
				cmp r0, r1
			is gt # b > b_1
				# адрес начала нового игрока
				br start_player
			else
				if
					cmp r0, r1 
				is z # b == b_1
					ldsa r1, 1
					ld r1, r1
					ldi r0, 2
					add r0, r1
					ld r1, r1
				
					ldi r0, 0xe6
					ld r0, r0
					
					if
						cmp r0, r1
					is gt # c > c_1
						# адрес начала нового игрока
						br start_player
					else
						if
							cmp r0, r1
						is z # c == c_1
							ldsa r1, 1
							ld r1, r1
							ldi r0, 3
							add r0, r1
							ld r1, r1
						
							ldi r0, 0xe7
							ld r0, r0
							
							if
								cmp r0, r1
							is gt # d > d_1
								# адрес начала нового игрока
								br start_player
							else # d <= d_1
								br next_player_or_last_player
							fi
						else # c < c_1	
							br next_player_or_last_player
						fi 
					fi
				else # b < b_1
						
					br next_player_or_last_player
				fi
			fi
		else # a < a_1
			 	
			br next_player_or_last_player	
		fi
		
	fi

	rts

start_player:
	ldsa r0, 1
	ld r0, r0
		
	ldi r1, 0xf0
	st r1, r0
	rts

next_player_or_last_player:
	ldsa r1, 1
	ld r1, r1
								
	ldi r0, 0xcc
								
	if 
		cmp r1, r0
	is z # это был последений игрок
		ldi r1, 0xf0
		ldi r0, 0xd8
		st r1, r0 # игрок становится в конец
		addsp 1
	else
		# переходим к следующему игроку
		ldi r0, 12
		add r0, r1
									
		push r1
		jsr func
	fi
	pop r0
	rts

shift:
	ldsa r0, 1 # откуда
	ld r0, r0
	
	ldi r2, 12
	move r0, r1
	add r2, r1 # куда
	
	ldi r2, 12
	while
		tst r2
	stays nz
		ld r0, r3
		st r1, r3
		
		inc r0
		inc r1
		dec r2
	wend
	rts
	
	
asect 0xa0
players:
	    ds 72
end
	