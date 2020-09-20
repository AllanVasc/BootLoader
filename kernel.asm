org 0x7e00
jmp 0x0000:start

data:   ;Todos os dados do programa ficarão aqui

    ;Strings do Menu
    stringTitle db 'Titulo...',0
    stringPlay db 'Start Game(1)',0
    stringHowToPlay db 'How To Play(2)',0
    stringCredits db 'Credits(3)',0

    ;Strings do Play
    stringPlayTitle db 'Play',0
    stringPlay1 db 'Coming Soon...',0

    ;Strings do Load
    stringLoad db 'Loading...', 0

    ;Strings do HowToPlay
    stringHowToPlayTitle db 'How To Play',0
    stringHowToPlay1 db 'Te vira meu pco...',0
    stringEsc   db 'Press ESC to return...',0

    ;Strings do Credits
    stringCreditsTitle db 'Credits',0
    stringCredits1 db 'Allan Soares Vasconcelos <asv>',0
    stringCredits2 db 'Amanda Lima Lassere <all2>',0
    stringCredits3 db 'Macio Monteiro de Meneses Jr <mmmj>',0
    stringCredits4 db 'Maria Isabel Fernandes dos Santos <mifs>',0

gets:   ;leitor de string (Com atualização para permitir backspace)

    xor cx, cx  ;Contador utilizado para permitir backspace

    .loop1:

        call getchar    ;Função para ler um char!
        cmp al, 0x08    ;Backspace
        je .backspace   ;Tratar do backSpace

        cmp al, 0x0d    ;Ve se foi inserido o enter (0x0d == 13)
        je .done

        cmp cl, 10      ;Limite da String
        je .loop1
    
        stosb           ;Vai guardar o char em AL para o DI       
        inc cl          ;Vai inc o contador de caracteres
        call putchar    ;Printa a letra
    
        jmp .loop1

    .backspace:

        cmp cl, 0       ;Conferindo para saber se já esta vazio
        je .loop1

        dec di          ;Deletando o ultimo char inserido
        dec cl
        mov byte[di], 0
        call delchar

        jmp .loop1

    .done:
    
        mov al, 0
        stosb
        call endl
        ret
    
getchar:    ;Pega o caractere lido no teclado e salva em al

    mov ah, 0x00
    int 16h
    ret

delchar:    ;Deleta um caractere lido no teclado

    mov al, 0x08          ;BackSpace
    call putchar
    mov al, ' '
    call putchar
    mov al, 0x08          ;BackSpace
    call putchar
    ret
  
endl:       ;Pula uma linha, printando na tela o caractere que representa o /n

    mov al, 0x0a          ; line feed
    call putchar
    mov al, 0x0d          ; carriage return
    call putchar
    ret

prints: ;mov si, string (Vai printar a string que o SI esta apontando)

    .loop:
        lodsb           ; bota character apontado por si em al 
        cmp al, 0       ; 0 é o valor atribuido ao final de uma string
        je .endloop     ; Se for o final da string, acaba o loop
        call putchar    ; printa o caractere
        jmp .loop       ; volta para o inicio do loop

    .endloop:
        ret

putchar:    ;Função responsavel por printar um caracter

    mov ah, 0x0e
    int 10h
    ret

clearTela:

    mov ah, 0
    mov al,12h
    int 10h
    ret


start:
    
    xor ax, ax      ;limpando ax
    mov ds, ax      ;limpando ds
    mov es, ax      ;limpando es

    call menu
    jmp done

menu:   ;Configurações do Menu

    call clearTela  ;Configurando o modo de video

    ;Colocando string "stringTitle"
	mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
    mov bl,15    ;Cor da String em bl
	mov dh, 3    ;Linha
	mov dl, 32   ;Coluna
	int 10h 
    mov si, stringTitle
    call prints

    ;Colocando string "stringPlay"
    mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
	mov dh, 15   ;Linha
	mov dl, 32   ;Coluna
	int 10h
    mov si, stringPlay
    call prints

    ;Colocando string "stringHowToPlay"
    mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
	mov dh, 20   ;Linha
	mov dl, 32   ;Coluna
	int 10h
    mov si, stringHowToPlay
    call prints

    ;Colocando string "stringCredits"
    mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
	mov dh, 25   ;Linha
	mov dl, 32   ;Coluna
	int 10h
    mov si, stringCredits
    call prints

    .selecao:

        call getchar

        cmp al, 49      ;Comparando com '1'
        je play

        cmp al, 50      ;Comparando com '2'
        je howToPlay
        
        cmp al, 51      ;Comparando com '3'
        je credits

        jmp .selecao    ;Se não for nenhuma das opções, fica no loop!

play:   ;Aqui ficara toda a lógica do jogo!

    call clearTela  ;Limpa a tela

    ;Colocando string "stringPlayTitle"
	mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
    mov bl,15    ;Cor da String em bl
	mov dh, 3    ;Linha
	mov dl, 32   ;Coluna
	int 10h 
    mov si, stringPlayTitle
    call prints

    ;Colocando string "stringPlay1"
	mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
    mov bl,15    ;Cor da String em bl
	mov dh, 15    ;Linha
	mov dl, 32   ;Coluna
	int 10h 
    mov si, stringPlay1
    call prints

    ;Colocando string "stringEsc"
	mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
    mov bl,15    ;Cor da String em bl
	mov dh, 28    ;Linha
	mov dl, 32   ;Coluna
	int 10h 
    mov si, stringEsc
    call prints

    jmp .retornoEsc

    .retornoEsc: 

        call getchar

        cmp al, 27  ;Se ele receber o Esc volta para o Menu
        je menu

        jne .retornoEsc

howToPlay:  ;Instruções do jogo

    call clearTela  ;Limpa a tela

    ;Colocando string "stringHowToPlayTitle"
	mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
    mov bl,15    ;Cor da String em bl
	mov dh, 3    ;Linha
	mov dl, 32   ;Coluna
	int 10h 
    mov si, stringHowToPlayTitle
    call prints

    ;Colocando string "stringHowToPlay1"
	mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
    mov bl,15    ;Cor da String em bl
	mov dh, 10    ;Linha
	mov dl, 32   ;Coluna
	int 10h 
    mov si, stringHowToPlay1
    call prints

    ;Colocando string "stringEsc"
	mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
    mov bl,15    ;Cor da String em bl
	mov dh, 28    ;Linha
	mov dl, 32   ;Coluna
	int 10h 
    mov si, stringEsc
    call prints

    jmp .retornoEsc

    .retornoEsc: 

        call getchar

        cmp al, 27  ;Se ele receber o Esc volta para o Menu
        je menu

        jne .retornoEsc

credits:    ;Créditos do jogo

    call clearTela  ;Limpa a tela

    ;Colocando string "stringCreditsTitle"
	mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
    mov bl,15    ;Cor da String em bl
	mov dh, 3    ;Linha
	mov dl, 32   ;Coluna
	int 10h 
    mov si, stringCreditsTitle
    call prints

    ;Colocando string "stringCredits1"
	mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
    mov bl,15    ;Cor da String em bl
	mov dh, 10    ;Linha
	mov dl, 5   ;Coluna
	int 10h 
    mov si, stringCredits1
    call prints

    ;Colocando string "stringCredits2"
	mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
    mov bl,15    ;Cor da String em bl
	mov dh, 11    ;Linha
	mov dl, 5   ;Coluna
	int 10h 
    mov si, stringCredits2
    call prints
    
    ;Colocando string "stringCredits3"
	mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
    mov bl,15    ;Cor da String em bl
	mov dh, 12    ;Linha
	mov dl, 5   ;Coluna
	int 10h 
    mov si, stringCredits3
    call prints

    ;Colocando string "stringCredits4"
	mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
    mov bl,15    ;Cor da String em bl
	mov dh, 13    ;Linha
	mov dl, 5   ;Coluna
	int 10h 
    mov si, stringCredits4
    call prints
    
    ;Colocando string "stringEsc"
	mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
    mov bl,15    ;Cor da String em bl
	mov dh, 28    ;Linha
	mov dl, 32   ;Coluna
	int 10h 
    mov si, stringEsc
    call prints

    jmp .retornoEsc

    .retornoEsc: 

        call getchar

        cmp al, 27  ;Se ele receber o Esc volta para o Menu
        je menu

        jne .retornoEsc

done:

    jmp $

;---------------------------------------------------------------------------------------------------------------------
;Funções que talvez use

tostring:              ; mov ax, int / mov di, string, transforma o valor em ax em uma string e salva no endereço apontado por di
    push di
    .loop1:
        cmp ax, 0
        je .endloop1
        xor dx, dx
        mov bx, 10
        div bx            ; ax = 9999 -> ax = 999, dx = 9
        xchg ax, dx       ; swap ax, dx
        add ax, 48        ; 9 + '0' = '9'
        stosb
        xchg ax, dx
        jmp .loop1
    .endloop1:
    pop si
    cmp si, di
    jne .done
    mov al, 48
    stosb
    .done:
    mov al, 0
    stosb
    call reverse
    ret

reverse:              ; mov si, string , pega a string apontada por si e a reverte 
  mov di, si
  xor cx, cx          ; zerar contador
  .loop1:             ; botar string na stack
    lodsb
    cmp al, 0
    je .endloop1
    inc cl
    push ax
    jmp .loop1
  .endloop1:
  .loop2:             ; remover string da stack        
    pop ax
    stosb
    loop .loop2
  ret

strcmp:              ; mov si, string1, mov di, string2, compara as strings apontadas por si e di
  .loop1:
    lodsb
    cmp al, byte[di]
    jne .notequal
    cmp al, 0
    je .equal
    inc di
    jmp .loop1
  .notequal:
    clc
    ret
  .equal:
    stc
    ret

clear:  ;Função para limpar a tela                  
 
    mov dx, 0       ;Set the cursor to top left-most corner of screen
    mov bh, 0      
    mov ah, 0x2
    int 0x10
    
    mov cx, 2000    ;Print 2000 blank chars to clean
    mov bh, 0
    mov al, 0x20    ;Blank char
    mov ah, 0x9
    int 0x10
    
    mov dx, 0       ;Reset cursor to top left-most corner of screen
    mov bh, 0      
    mov ah, 0x2
    int 0x10
    ret