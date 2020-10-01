org 0x7e00
jmp 0x0000:start

data:   ;Todos os dados do programa ficarão aqui

    ;Strings do Menu
    stringTitle db 'Titulo...',0
    stringPlay db 'Start Game(1)',0
    stringHowToPlay db 'How To Play(2)',0
    stringCredits db 'Credits(3)',0

    ;Strings do Play
    stringPlayTitle db 'Sudoku',0

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

    ;Sudoku

    whiteColor equ 15
    greenColor equ 2
    redColor equ 4

    sudokuBackup    db '5','7','4','2','3','6','9','8','1'
                    db '6','8','3','4','9','1','7','5','2'
                    db '2','1','9','7','8','5','4','6','3'
                    db '9','4','8','5','1','2','3','7','6'
                    db '7','3','6','9','4','8','1','2','5'
                    db '1','5','2','6','7','3','8','4','9'
                    db '3','6','1','8','2','7','5','9','4'
                    db '4','2','7','3','5','9','6','1','8'
                    db '8','9','5','1','6','4','2','3','7', 0 ;Esse 0 a mais sinaliza o fim!

    sudokuPlaying    db '0','7','4','0','0','0','0','8','1'
                    db '6','0','0','4','9','1','0','0','0'
                    db '2','0','0','0','0','5','4','0','3'
                    db '0','4','0','0','1','2','3','7','0'
                    db '0','3','0','9','4','0','1','0','5'
                    db '0','5','2','6','0','3','0','4','0'
                    db '0','0','1','8','2','0','0','9','4'
                    db '4','0','0','3','0','9','6','0','0'
                    db '8','0','5','0','6','0','2','0','0', 0 ;Esse 0 a mais sinaliza o fim!

    CanChangeSudoku db '1','0','0','1','1','1','1','0','0'
                    db '0','1','1','0','0','0','1','1','1'
                    db '0','1','1','1','1','0','0','1','0'
                    db '1','0','1','1','0','0','0','0','1'
                    db '1','0','1','0','0','1','0','1','0'
                    db '1','0','0','0','1','0','1','0','1'
                    db '1','1','0','0','0','1','1','0','0'
                    db '0','1','1','0','1','0','0','1','1'
                    db '0','1','0','1','0','1','0','1','1', 0 ;Esse 0 a mais sinaliza o fim! 

    msgLinhaAtual db 'Linha:' , 0
    msgColunaAtual db 'Coluna:' , 0
    msgCantChange db 'Cant change' , 0

    linhaSudoku TIMES 2 db 0
    colunaSudoku TIMES 2 db 0

    endl db ' ',13,10,0

prints: ;mov si, string (Vai printar a string que o SI esta apontando)

    .loop:

        lodsb               ; bota character apontado por si em al 
        cmp al, 0           ; 0 é o valor atribuido ao final de uma string
            je .endloop     ; Se for o final da string, acaba o loop
        call putChar        ; printa o caractere

        jmp .loop           ; volta para o inicio do loop

    .endloop:

        ret

printsSudoku:               ; mov si, string (Vai printar a string que o SI esta apontando)

    xor cx, cx              ;Contador utilizado para pular as linhas!

    .loop:

        lodsb               ; bota character em SI para o AL 
        cmp al, 0
            je .endloop

        cmp al, '0'         ;Se for '0' muda a cor para vermelho!
            je .putRed

        mov bl, greenColor  ;Se não for, printa o verde!
        call putChar

        inc cx              ;Contando a quantidade de digitos
        cmp cx, 9           ;Se for igual a 9 precisa pular a linha
            je .putEndl

        jmp .loop

    .putRed:

        mov bl, redColor
        call putChar

        inc cx              ;Contando a quantidade de digitos
        cmp cx, 9           ;Se for igual a 9 precisa pular a linha
            je .putEndl

        jmp .loop

    .putEndl:

        xor cx, cx  ;       Zerando novamente o contador!     
        mov al, 13
        call putChar
        mov al, 10
        call putChar
        call colocaEspaco
        jmp .loop

    .endloop:
        ret

colocaEspaco:       ;Usada para centralizar o sudoku no meio da tela

    xor cx,cx

    .loop:

        cmp cx,36   ;Modificar esse número para centralização
            je .done

        mov al, ' '
        call putChar
        inc cx
        
        jmp .loop

    .done:

        xor cx,cx
        ret

putChar:    ;Função responsavel por printar um caracter

    mov ah, 0x0e
    int 10h
    ret
  
putEndl:        ;Pula uma linha, printando na tela o caractere que representa o /n

    mov al, 0x0a    ; line feed
    call putChar
    mov al, 0x0d    ; carriage return
    call putChar
    ret

getChar:    ;Pega o caractere lido no teclado e salva em al

    mov AH, 0x00
    int 16h
    ret

strcpy: ;Função para copiar uma String na outra mov SI, String 1 ; mov DI, String 2 (String 2 <- String 1)

    .loop1:

        lodsb
        stosb
        cmp al, 0
            je .endloop1
        jmp .loop1

    .endloop1:
        ret

clearTela:  ;Função responsável por atualizar a tela

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
    mov bl,whiteColor   ;Cor da String em bl
	mov dh, 3    ;Linha
	mov dl, 32   ;Coluna
	int 10h 
    mov si, stringTitle
    call prints

    ;Colocando string "stringPlay"
    mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
	mov dh, whiteColor   ;Linha
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

        call getChar

        cmp al, 49      ;Comparando com '1'
        je play

        cmp al, 50      ;Comparando com '2'
        je howToPlay
        
        cmp al, 51      ;Comparando com '3'
        je credits

        jmp .selecao    ;Se não for nenhuma das opções, fica no loop!

play:   ;Aqui ficara toda a lógica do jogo!

    call clearTela  ;Limpa a tela
    mov SI, linhaSudoku ;Zerando as variaveis antes de iniciar
    mov al, 0
    mov [esi], al        
    mov SI, colunaSudoku 
    mov [esi], al
            
    mov SI, sudokuBackup ;Copiando o novo jogo...
    mov DI, sudokuPlaying
    call strcpy

    .loop:

        ;Colocando string "stringPlayTitle"
        mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
        mov bh, 0    ;Pagina 0
        mov bl,whiteColor    ;Cor da String em bl
        mov dh, 3    ;Linha
        mov dl, 32   ;Coluna
        int 10h 
        mov si, stringPlayTitle
        call prints

        ;Colocando string "stringEsc"
        mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
        mov bh, 0    ;Pagina 0
        mov bl,whiteColor    ;Cor da String em bl
        mov dh, 28    ;Linha
        mov dl, 32   ;Coluna
        int 10h 
        mov si, stringEsc
        call prints

        ;Colocando o sudoku
        mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
        mov bh, 0    ;Pagina 0
        mov dh, 8    ;Linha
        mov dl, 36   ;Coluna
        int 10h 
        mov SI, sudokuPlaying  
        call printsSudoku

        ;Debugando para saber a linha e a coluna atual!
        call putEndl
        mov bl, whiteColor
        mov SI, msgLinhaAtual  
        call prints

        mov SI, linhaSudoku ;SI ira apontar para o endereço da variavel  
        mov al, [esi]       ;Pegamos o valor o qual o SI está apontando 
        add al,'0'
        call putChar

        call putEndl

        mov SI, msgColunaAtual  
        call prints
        mov SI, colunaSudoku  
        mov al, [esi]      ; Load a double word from memory into eax
        add al,'0'
        call putChar

        ;Lógica de incrementar e decrementar a linha e a coluna
        call getChar

        cmp al, 'w'
            je .decrementaLinha

        cmp al, 'a'
            je .decrementaColuna

        cmp al, 's'
            je .incrementaLinha

        cmp al, 'd'
            je .incrementaColuna

        ;Lógica de mudar os numeros da matriz!

        cmp al,'1'
            je .mudaMatriz
        cmp al,'2'
            je .mudaMatriz
        cmp al,'3'
            je .mudaMatriz
        cmp al,'4'
            je .mudaMatriz
        cmp al,'5'
            je .mudaMatriz
        cmp al,'6'
            je .mudaMatriz
        cmp al,'7'
            je .mudaMatriz
        cmp al,'8'
            je .mudaMatriz
        cmp al,'9'
            je .mudaMatriz

        cmp al, 27  ;Se ele receber o "Esc" volta para o Menu!
            je menu

;        cmp al, 13  ;Se ele receber o "Enter" checa a resposta!
;            je checaResposta
        
        jmp .loop

    .decrementaLinha:

        mov SI, linhaSudoku  
        mov al, [esi]      ; Load a double word from memory into eax
        cmp al, 0          ;Se já esta no limite não faz nada
            je .loop

        dec al
        mov [esi], al      ; Store a double word in eax into memory
        call clearTela

        jmp .loop 

    .decrementaColuna:

        mov SI, colunaSudoku  
        mov al, [esi]      ; Load a double word from memory into eax
        cmp al, 0          ;Se já esta no limite não faz nada
            je .loop

        dec al
        mov [esi], al      ; Store a double word in eax into memory
        call clearTela

        jmp .loop

    .incrementaLinha:

        mov SI, linhaSudoku  
        mov al, [esi]      ; Load a double word from memory into eax
        cmp al, 8          ;Se já esta no limite não faz nada
            je .loop

        inc al
        mov [esi], al      ; Store a double wosrd in eax into memory
        call clearTela

        jmp .loop

    .incrementaColuna:

        mov SI, colunaSudoku  
        mov al, [esi]      ; Load a double word from memory into eax
        cmp al, 8          ;Se já esta no limite não faz nada
            je .loop

        inc al
        mov [esi], al      ; Store a double word in eax into memory
        call clearTela

        jmp .loop

    .mudaMatriz:        ;(DH == Linha sudoku e DL == ColunaSudoku )

        mov cl, al      ;Cl ira guardar temporariamente al
        xor edi, edi    ;Zerando o di

        mov SI, linhaSudoku  
        mov dh, [esi]      ; Load a double word from memory into eax
        mov SI, colunaSudoku  
        mov dl, [esi]      ; Load a double word from memory into eax

        mov al, 9           ;Inicio do calculo da posição da matriz!
        mul DH              ; AL = AL * DH
        add al, dl          ;O valor da posição da matriz estara em al!
        mov edi, eax        ;Passando valor de al para o registrador de segmento(como se fosse ponteiro)
        
        ;Irei descobrir se eu posso mudar ou se são os valores padrões!
        mov SI, CanChangeSudoku
        mov dl, [esi + edi]         ;dl ficara com '0' ou '1'
        cmp dl, '0'                 ;Se não pode mudar volta para o loop
            je .cantChange

        mov SI, sudokuPlaying       ;Se for possivel mudar,ele muda a matriz!
        mov [esi + edi], cl
        call clearTela

        jmp .loop
    
    .cantChange:

        ;Colocando string "Cant Change"
        mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
        mov bh, 0    ;Pagina 0
        mov bl, redColor    ;Cor da String em bl
        mov dh, 15    ;Linha
        mov dl, 60   ;Coluna
        int 10h 
        mov si, msgCantChange
        call prints

        jmp .loop

howToPlay:  ;Instruções do jogo

    call clearTela  ;Limpa a tela

    ;Colocando string "stringHowToPlayTitle"
	mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
    mov bl,whiteColor    ;Cor da String em bl
	mov dh, 3    ;Linha
	mov dl, 32   ;Coluna
	int 10h 
    mov si, stringHowToPlayTitle
    call prints

    ;Colocando string "stringHowToPlay1"
	mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
    mov bl,whiteColor    ;Cor da String em bl
	mov dh, 10    ;Linha
	mov dl, 32   ;Coluna
	int 10h 
    mov si, stringHowToPlay1
    call prints

    ;Colocando string "stringEsc"
	mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
    mov bl,whiteColor    ;Cor da String em bl
	mov dh, 28    ;Linha
	mov dl, 32   ;Coluna
	int 10h 
    mov si, stringEsc
    call prints

    jmp .retornoEsc

    .retornoEsc: 

        call getChar

        cmp al, 27  ;Se ele receber o Esc volta para o Menu
        je menu

        jne .retornoEsc

credits:    ;Créditos do jogo

    call clearTela  ;Limpa a tela

    ;Colocando string "stringCreditsTitle"
	mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
    mov bl,whiteColor    ;Cor da String em bl
	mov dh, 3    ;Linha
	mov dl, 32   ;Coluna
	int 10h 
    mov si, stringCreditsTitle
    call prints

    ;Colocando string "stringCredits1"
	mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
    mov bl,whiteColor    ;Cor da String em bl
	mov dh, 10    ;Linha
	mov dl, 5   ;Coluna
	int 10h 
    mov si, stringCredits1
    call prints

    ;Colocando string "stringCredits2"
	mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
    mov bl,whiteColor    ;Cor da String em bl
	mov dh, 11    ;Linha
	mov dl, 5   ;Coluna
	int 10h 
    mov si, stringCredits2
    call prints
    
    ;Colocando string "stringCredits3"
	mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
    mov bl,whiteColor    ;Cor da String em bl
	mov dh, 12    ;Linha
	mov dl, 5   ;Coluna
	int 10h 
    mov si, stringCredits3
    call prints

    ;Colocando string "stringCredits4"
	mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
    mov bl,whiteColor    ;Cor da String em bl
	mov dh, 13    ;Linha
	mov dl, 5   ;Coluna
	int 10h 
    mov si, stringCredits4
    call prints
    
    ;Colocando string "stringEsc"
	mov ah, 02h  ;Permite que a gente coloque a string em alguma posicao da tela (set cursor)
	mov bh, 0    ;Pagina 0
    mov bl,whiteColor    ;Cor da String em bl
	mov dh, 28    ;Linha
	mov dl, 32   ;Coluna
	int 10h 
    mov si, stringEsc
    call prints

    jmp .retornoEsc

    .retornoEsc: 

        call getChar

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

gets:   ;leitor de string (Com atualização para permitir backspace)

    xor cx, cx  ;Contador utilizado para permitir backspace

    .loop1:

        call getChar    ;Função para ler um char!
        cmp al, 0x08    ;Backspace
        je .backspace   ;Tratar do backSpace

        cmp al, 0x0d    ;Ve se foi inserido o enter (0x0d == 13)
        je .done

        cmp cl, 10      ;Limite da String
        je .loop1
    
        stosb           ;Vai guardar o char em AL para o DI       
        inc cl          ;Vai inc o contador de caracteres
        call putChar    ;Printa a letra
    
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
        call putEndl
        ret

delchar:    ;Deleta um caractere lido no teclado

    mov al, 0x08          ;BackSpace
    call putChar
    mov al, ' '
    call putChar
    mov al, 0x08          ;BackSpace
    call putChar
    ret