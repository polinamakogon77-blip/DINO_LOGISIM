asect 0x00
push r3


# обновление рекордов
update:
	pop r3
	ldi r0, current_1
	ld r0, r0
	st r0, r0
	
	ldi r0, current_2
	ld r0, r0
	st r0, r0
	
	ldi r0, top1_1
	ld r0, r0
	st r0, r0
	
	ldi r0, top1_2
	ld r0, r0
	st r0, r0
	
	ldi r0, top2_1
	ld r0, r0
	st r0, r0
	
	ldi r0, top2_2
	ld r0, r0
	st r0, r0
	
	ldi r0, top3_1
	ld r0, r0
	st r0, r0
	
	ldi r0, top3_2
	ld r0, r0
	st r0, r0
	
	jsr cmp_1
	
# сравнение с первым местом
cmp_1:
	pop r3
	ldi r0, top1_1
	ld r0, r0
	
	ldi r2, top1_2
	ld r2, r2
	
	ldi r1, current_1
	ld r1, r1

	if
		cmp r0, r1
	is mi
		jsr replaceTop1 # текущий игрок стал первым
	else
		if
			cmp r0, r1
		is z # сравниваем младший байт
			ldi r1, current_2
			ld r1, r1
		
			if
				cmp r2, r1
			is mi
				jsr replaceTop1 # текущий игрок стал первым
			else
				if
					cmp r2, r1
				is z
					jsr update # текущий игрок и так уже первый
				else
					jsr cmp_2 # сравнение со следующим местом
				fi
			fi
		else
			jsr cmp_2 # сравнение со следующим местом
		fi		
	fi
	
# сравнение со вторым местом	
cmp_2:
	pop r3
	ldi r0, top2_1
	ld r0, r0
	
	ldi r2, top2_2
	ld r2, r2
	
	ldi r1, current_1
	ld r1, r1
	
	if
		cmp r0, r1
	is mi
		jsr replaceTop2
	else
		if
			cmp r0, r1
		is z
			ldi r1, current_1
			ld r1, r1
			
			if
				cmp r2, r1
			is mi
				jsr replaceTop2
			else
				if
					cmp r2, r1
				is z
					jsr update
				else
					jsr cmp_3
				fi
			fi
		else
			jsr cmp_3
		fi		
	fi
	
cmp_3:
	pop r3
	ldi r0, top3_1
	ld r0, r0
	
	ldi r2, top3_2
	ld r2, r2
	
	ldi r1, current_1
	ld r1, r1

	if
		cmp r0, r1
	is mi
		jsr replaceTop3
	else
		if
			cmp r0, r1
		is z
			ldi r1, current_2
			ld r1, r1
			
			if
				cmp r2, r1
			is mi
				jsr replaceTop3
			else
				if
					cmp r2, r1
				is z
					jsr update
				fi
			fi
		else
			jsr update
		fi		
	fi

# вставка на первое место
replaceTop1:
	pop r3
	
	ldi r0, top2_1
	ld r0, r0
	ldi r1, top3_1
	st r1, r0
	
	ldi r0, top2_2
	ld r0, r0
	ldi r1, top3_2
	st r1, r0
	
	ldi r0, top1_1
	ld r0, r0
	ldi r1, top2_1
	st r1, r0
	
	ldi r0, top1_2
	ld r0, r0
	ldi r1, top2_2
	st r1, r0
	
	ldi r0, current_1
	ld r0, r0
	ldi r1, top1_1
	st r1, r0
	
	ldi r0, current_2
	ld r0, r0
	ldi r1, top1_2
	st r1, r0
	
	jsr update
	
# вставка на второе место
replaceTop2:
	pop r3
	
	ldi r0, top2_1
	ld r0, r0
	ldi r1, top3_1
	st r1, r0
	
	ldi r0, top2_2
	ld r0, r0
	ldi r1, top3_2
	st r1, r0
	
	ldi r0, current_1
	ld r0, r0
	ldi r1, top2_1
	st r1, r0
	
	ldi r0, current_2
	ld r0, r0
	ldi r1, top2_2
	st r1, r0
	
	jsr update	

# вставка на третье место
replaceTop3:
	pop r3
	
	ldi r0, current_1
	ld r0, r0
	ldi r1, top3_1
	st r1, r0
	
	ldi r0, current_2
	ld r0, r0
	ldi r1, top3_2
	st r1, r0
	
	jsr update	
	
jsr update

asect 0xF4
top1_1: ds 1
top1_2: ds 1

top2_1: ds 1
top2_2: ds 1

top3_1: ds 1
top3_2: ds 1

current_1: ds 1
current_2: ds 1

end
